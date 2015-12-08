use v6;

my $server = IO::Socket::INET.new(
  :localport(7041),
  :type(1),
  :reuse(1),
  :listen(10)
);

#loop {
  my $connection = $server.accept;
  while my $inc = $connection.recv(:bin) {
    say 'okay, I got something';
    $connection.write: $inc;
  }
#}
