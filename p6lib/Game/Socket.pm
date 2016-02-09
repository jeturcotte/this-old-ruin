use nqp;

class Game::Socket is IO::Socket::Async {
    my class SocketCancellation is repr('AsyncTask') { }
    has $!VMIO;
    has str $!client_name;

    method listen(IO::Socket::Async:U: Str() $host, Int() $port, Int() $backlog = 128, :$scheduler = $*SCHEDULER) {
        my $cancellation;
        Supply.on-demand(-> $s {
            $cancellation := nqp::asynclisten(
                $scheduler.queue,
                -> Mu \socket, Mu \err {
                    if err {
                        $s.quit(err);
                    }
                    else {
                        my $client_socket := nqp::create(self);
                        my $numerical_name = $client_socket ~~ /\d+/;
                        say "client socket $client_socket created";
                        nqp::bindattr($client_socket, IO::Socket::Async, '$!VMIO', socket);
                        nqp::bindattr_s($client_socket, Game::Socket, '$!client_name', ~$numerical_name); 
                        $s.emit($client_socket);
                    }
                },
                $host, $port, $backlog, SocketCancellation);
        },
        closing => {
            $cancellation && nqp::cancel($cancellation)
        });
    }

    method name() {
      return $!client_name;
    }

}
