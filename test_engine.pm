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
  say "game tic elapsed with a process usage of $tic_leeway\% ($time_elapsed milliseconds used out of $maximum_wait_time)";
  sleep(($maximum_wait_time - $time_elapsed)/1000);
}

sub get_player_commands {
  say 'about to react';
  react {
    say 'reacted... you know, whenever';
    whenever IO::Socket::Async.listen('localhost',3333) -> $conn {
      say 'we need a supply of bytes';
      my $bs = $conn.bytes-supply;
      say "we have a supply of bytes ($bs)";
      $bs.tap(-> $buf { await $conn.write: $buf } );
      say "we just tapped something... now we wait";
      $bs.wait;
      say "did we just wait?";
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
