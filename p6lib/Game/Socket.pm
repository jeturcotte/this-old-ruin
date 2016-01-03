class Game::Socket is IO::Socket::Async {

    method listen(Game::Socket:U: Str() $host, Int() $port, Int() $backlog = 128,
                  :$scheduler = $*SCHEDULER) {
        my $cancellation;
        say "wheeeeeee";
        Supply.on-demand(-> $s {
            $cancellation := nqp::asynclisten(
                $scheduler.queue,
                -> Mu \socket, Mu \err {
                    if err {
                        $s.quit(err);
                    }
                    else {
                        my $client_socket := nqp::create(self);
                        nqp::bindattr($client_socket, Game::Socket, '$!VMIO', socket);
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
