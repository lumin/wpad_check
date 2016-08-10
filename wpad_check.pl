#!/usr/bin/perl
# by lumin 2016
# perl wpad_check.pl tlds.list

sub gethost($){
	my $addr=gethostbyname($_[0]);
	return join('.',unpack("C4",$addr));
}

sub get_wpad($){
	my $wpad=`wget -O - -q "$_[0]/wpad.dat"`;
	
	return(length($wpad),$wpad);
}

sub main{
	open (IN,$ARGV[0]);
	my @tld;
	while(<IN>){
		chomp $_;
		push (@tld,$_);
	}

	for (@tld){
		my $domain=$_;
		my $host=gethost("wpad.".$_);
		my ($wpadsize,$wpad)=get_wpad("wpad.".$_);
		
		print $domain,",",$host,",",$wpadsize,"\n";
		if ($wpadsize ne 0){
			open(OUT,">wpad.".$domain.".wpad.dat");
			print OUT $wpad;
			print $wpad;
			close(OUT);
		}
	}

}

main();
exit();
