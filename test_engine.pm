use v6;

start get_player_commands(); 
our $target_tics_per_second = 24;
our $ten_tic_seconds = $target_tics_per_second * 10;
our $game_hour = 60 * 5 * $target_tics_per_second; 
our $maximum_wait_time_in_milliseconds = 1000 / $target_tics_per_second;
our $begin_time;
our $time_elapsed;
our $tic_leeway;
our $which_tic = 0;

while (1) {
  $begin_time = DateTime.now().Instant; 
  process_player_commands();
  calculate_game_events();
  report_events_to_player();
  my $time_elapsed = (DateTime.now().Instant - $begin_time) * 1000;  
  #my $tic_leeway = ($time_elapsed / $maximum_wait_time) * 100;
  #say "game tic elapsed with a process usage of $tic_leeway\% ($time_elapsed milliseconds used out of $maximum_wait_time)";
  sleep( ($maximum_wait_time_in_milliseconds - $time_elapsed) / 1000 );
}

sub get_player_commands {
  react {
    whenever IO::Socket::Async.listen('localhost',3333) -> $conn {
      my $bs = $conn.bytes-supply;
      $bs.tap(-> $buf { await $conn.write: $buf } );
      say 'player command received';
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
  determine_if_game_hour_has_passed(); 
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

sub determine_if_game_hour_has_passed {
  $which_tic++;
  #unless $which_tic % $ten_tic_seconds {
  #  say "$ten_tic_seconds tics (10 seconds) have passed"
  #}
  if $which_tic == $game_hour {
    say "A game hour ($which_tic tics) has passed";
    $which_tic = 0;
  }
}
