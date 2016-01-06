use nqp;

class Game::Socket is IO::Socket::Async {
    my class SocketCancellation is repr('AsyncTask') { }
    has $!VMIO;

    method listen(IO::Socket::Async:U: Str() $host, Int() $port, Int() $backlog = 128,
                  :$scheduler = $*SCHEDULER) {
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
                        say "wheeee: $client_socket";
                        nqp::bindattr($client_socket, IO::Socket::Async, '$!VMIO', socket);
                        $s.emit($client_socket);
                    }
                },
                $host, $port, $backlog, SocketCancellation);
        },
        closing => {
            $cancellation && nqp::cancel($cancellation)
        });
    }

}
