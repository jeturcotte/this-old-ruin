class Game {

  has $!address;
  has $!port;
  has $.welcome_message;
  has %.connected_clients;

  method listener {

    react {
      my $interpreter = Game::Commands.new;

      # establish connection with client
      whenever Game::Socket.listen($address,$port) -> $conn {
        $conn.write: $welcome_message.encode();
        %connected_clients{$conn.name()} = time;
      
        # listen for and reply to messages from the client
        whenever $conn.Supply(:bin) -> $incoming {
          my $command = $interpreter.Normalize($message); 
          await $conn.write: $interpreter.Respond($command).encode();
        }

        # dispatch emitted messages from the server
        $outgoing.tap(-> $message {
          my ($client, $out) = $message.split("|");
          if ($client eq 'global') {
            $conn.write: "$out> ".encode();
          } elsif ($client eq $conn.name()) {
            $conn.write: "$out> ".encode();
          }
        });
      } 
    }

  } # end method listener

}
