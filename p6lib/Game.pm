class Game {

  has $!address;
  has $!port;
  has $.welcome_message;
  has %.connected_clients;

  has $!in = Supplier.new;
  has $!incoming = $in.Supply;
  has $!out = Supplier.new;
  has $!outgoing = $out.Supply;

	method tick {
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
	}

  method dialogue {
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
  } # end dialogue method

	method process_player_commands { }
	
	method calculate_game_events { }
	
	method determine_if_game_hour_has_passed {
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

}
