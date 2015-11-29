use v6;

get_player_commands(); 
our $target_tics_per_second = 30;
our $maximum_wait_time = 1000 / $target_tics_per_second;
our $begin_time;
our $time_elapsed;
our $tic_leeway;

while (1) {
  $begin_time = DateTime.now().Instant; 
  process_player_commands();
  calculate_game_events();
  report_events_to_player();
  my $time_elapsed = (DateTime.now().Instant - $begin_time) * 1000;  
  my $tic_leeway = ($time_elapsed / $maximum_wait_time) * 100;
  sleep($maximum_wait_time - $time_elapsed);
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

sub process_player_commands {
  # process player movement request
    # is player restricted by constraint ?
    # is player restricted by conflict ?
    # is player restricted by lack of pathway ?
}

sub calculate_game_events {
  # process ongoing registered incidents
  # process creature movement request
  # process climate change request  
}

sub report_events_to_player {
  # print incident report to screen
  # if player requested movement AND movement allowed
    # report arrival at new room
    # report presense of creature in new room
    # report presense of ovbject in new room
    # report important climate information
    # report alteration in climate information
  # otherwise, report failure to move to new room
}
