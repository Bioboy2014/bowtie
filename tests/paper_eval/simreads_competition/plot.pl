#!/usr/bin/perl -w

use strict;
use warnings;

defined($ARGV[0]) || die "Must specify run names";
my @runnames = @ARGV; # -> column names

open(RUNTIME, ">runtime.tex") || die "Could not open >runtime.tex";
print RUNTIME "\\documentclass{article}\n";
print RUNTIME "\\begin{document}\n";
print RUNTIME "\\begin{tabular}{ | l || ";
for(my $i = 0; $i <= $#runnames; $i++) {
	print RUNTIME "r | ";
}
print RUNTIME "}\n";
print RUNTIME "\\hline\n";
print RUNTIME " & Human Chromosome 22 & Human Chromosome 2 & Whole Human Genome \\\\ \\hline \n";

open(MEMORY, ">memory.tex") || die "Could not open >memory.tex";
print MEMORY "\\documentclass{article}\n";
print MEMORY "\\begin{document}\n";
print MEMORY "\\begin{tabular}{ | l || ";
for(my $i = 0; $i <= $#runnames; $i++) {
	print MEMORY "r | ";
}
print MEMORY "}\n";
print MEMORY "\\hline\n";
print MEMORY " & Human Chromosome 22 & Human Chromosome 2 & Whole Human Genome \\\\ \\hline \n";

sub readlines {
	my $f = shift;
	my @ret;
	open(FILE, $f) || die "Could not open $f";
	while(<FILE>) {
		chomp;
		push(@ret, $_)
	}
	return @ret;
}

sub readfline {
	my $f = shift;
	my $l = shift;
	my @ret;
	open(FILE, $f) || die "Could not open $f";
	while(<FILE>) {
		chomp;
		push(@ret, $_)
	}
	return $ret[$l] if $l <= $#ret;
	return "";
}

# Output 
for(my $i = 0; $i < 5; $i++) {
	foreach my $n (@runnames)  {
		my $l = readfline("$n.results.txt", $i);
		if($l eq "") {
			print RUNTIME "- ";
		} else {
			my @s = split(/ /, $l);
			my @s2 = split(/,/, $s[1]);
			print RUNTIME "$s2[0] ";
		}
		if($i < 4) { print RUNTIME "& "; }
	}
	print RUNTIME " \\\\ \\hline \n";
}

# Output 
for(my $i = 0; $i < 5; $i++) {
	foreach my $n (@runnames)  {
		my $l = readfline("$n.results.txt", $i);
		if($l eq "") {
			print MEMORY "- ";
		} else {
			my @s = split(/ /, $l);
			my @s2 = split(/,/, $s[1]);
			print MEMORY "$s2[1] ($s2[2]) ";
		}
		if($i < 4) { print MEMORY "& "; }
	}
	print MEMORY " \\\\ \\hline \n";
}

print RUNTIME "\\end{tabular}\n";
print RUNTIME "\\end{document}\n";

print MEMORY "\\end{tabular}\n";
print MEMORY "\\end{document}\n";

close(RUNTIME);
close(MEMORY);
