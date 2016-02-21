use v6;
use lib 'p6lib';
use Game::Socket;
use Game::Commands;


# TODO -- Pull the following from config instead
  our $port = 7041;
  our $target_tics_per_second = 16;
  our $ten_tic_seconds = $target_tics_per_second * 10;
  our $game_hour = 60 * 5 * $target_tics_per_second; 
  our $maximum_wait_time_in_milliseconds = 1000 / $target_tics_per_second;
  our $begin_time;
  our $time_elapsed;
  our $tic_leeway;
  our $which_tic = 0;
  our %client_connections;
# TODO -- and/or accept command line arguments as override



# MAIN GAME LOOP
  our $in = Supplier.new;
  our $incoming = $in.Supply;
  our $out = Supplier.new;
  our $outgoing = $out.Supply;
  our $interpreter = Game::Commands.new;
  start accept_player_commands();

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
# END GAME LOOP



# CLIENT CONNECTION AND INTERFACE
  sub accept_player_commands {
    react {

    # ESTABLISH CONNECTION WITH CLIENT
      whenever Game::Socket.listen('localhost',$port) -> $conn {
        $conn.write: "welcome; the server dubs thee $conn.name()\n".encode();
        %client_connections{$conn.name()} = time;

      # LISTEN FOR CLIENT COMMANDS
        whenever $conn.Supply(:bin) -> $incoming {
          my $command = $interpreter.Normalize($incoming); #.decode('UTF-8').chomp.uc;
          await $conn.write: $interpreter.Respond($command).encode();
        }

      # OR EMIT MESSAGES TO THE CLIENT(S)
        $outgoing.tap(-> $message { 
          my ($client, $out) = $message.split("|"); 
          if ($client eq 'global') {
            $conn.write: "GLOBAL -> $out\n".encode();
          } elsif ($client eq $conn.name()) {
            $conn.write: "PRIVATE -> $out\n".encode();
          }
        });
      }
    }
  }
# END CLIENT CONNECTIONS



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
  my $target = 'global';
  unless $which_tic % $ten_tic_seconds {
    if (Int(2.rand)) {
      $target = %client_connections.keys[Int(%client_connections.elems.rand)];
    }
    $out.emit("$target|$ten_tic_seconds tics (10 seconds) have passed");
  }
  if $which_tic == $game_hour {
    $out.emit("global|A game hour ($which_tic tics) has passed");
    $which_tic = 0;
  }
}
