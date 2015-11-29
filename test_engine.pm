use v6;

while (1) {
  get_player_commands();
  calculate_game_events();
  report_events_to_player();  
}

sub get_player_commands {
 react {
    whenever IO::Socket::Async.listen('localhost',3333) -> $conn {
      my $bs = $conn.bytes-supply;
      $bs.tap(-> $buf { await $conn.write: $buf } );
      $bs.wait;
    }
  }
}

sub calculate_game_events { }

sub report_events_to_player { }
