package Audio::GetFormat;


sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	$self->init(@_);
	return $self;
}

sub init {
	my $self = shift;
	my %args = @_;
	$self->{file} = $args{file};
	if (defined($args{debug})) {
		$self->{debug} = $args{debug};
	} else {
		$self->{debug} = 0;
	}		
}


sub getFile {
	my $self = shift;
	return $self->{file};
}


sub getFormat {
	my $self = shift;

	my @ffmpegOutput = `ffmpeg -i '$self->{file}' 2>&1`;

	foreach my $line (@ffmpegOutput) {
		if ($self->{debug}) {
			print "$line\n";
		}
		if ($line =~ /Input #0, (\S+), from '$self->{file}'/) {
			return $1;
		}
	}
	die "Could not determine audio type from ffmpeg output\n";
}


1;


