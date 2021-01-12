#! /usr/bin/perl
# NASZVADI Peter, 2016, All rights reserved!
# Untested version
# This is a complete 8085 assembler, with ORG, EQU, labels, DS/DB/DW
sub keplet {
    my $p = shift;
    my $firstchar = '';
    my $remaining = '';
    my $trimmed = '';
    if($p =~ m/^\s*((\S)(.*?))\s*$/g ){
         $firstchar=$2;
         $remaining=$3;
         $trimmed=$1;
    }
    if($firstchar eq ''){return 0;}
    if($firstchar eq '+'){return &keplet($trimmed);}
    if($firstchar eq '('){
         my $j=0;
         my $depth=1;
         while($depth>0){
              my $c=substr($remaining,$j,1);
              if($c eq '('){$depth++;}
              elsif($c eq ')'){$depth--;}
              $j++;
         }
         $j--;
         return(&keplet(&keplet(substr($remaining,0,$j)).' '.substr($remaining,$j+1)));
    }
    if($trimmed =~ m(^\s*((?:-+\s*)*)((?:[_A-Za-z0-9]+|\$|'[^']+'|"[^"]+"))\s*(\sAND\s|\sX?OR\s|\sSH[RL]\s|[-%\+*/])\s*(.*))ig ){
        my $sign=$1;
        my $first=$2;
        my $second=lc($3);
        my $third=$4;
        $second=~s/\s//g;
        $sign=(-1)**(split(/-/,$sign));
        if($first=~m/^[0-9]+$/){
            $first=$sign*$first;
        }
        elsif($first =~ m/^[0-9a-f]+h$|^0x[0-9a-f]+$/i){
            $first=$sign*hex($first);
        }
        elsif($first =~ m/["'](.)/){
            $first=$sign*ord($1);
        }
        elsif($first =~ m/\$/){
            $first=$sign*$PC;
        }
        else{
            if((defined $Variable{$first}[1])and($Variable{$first}[1]==1)){
                $first=$sign*$Variable{$first}[0];
            }else{
                $Variable{$first}[0]=&keplet($Variable{$first}[2]);
                $Variable{$first}[1]=1;
                $first=$sign*$Variable{$first}[0];
            }
        }
        if($second eq 'and'){ return($first & &keplet($third)); }
        if($second eq 'or'){ return($first | &keplet($third)); }
        if($second eq 'xor'){ return($first ^ &keplet($third)); }
        if($second eq 'shl'){ return($first << &keplet($third)); }
        if($second eq 'shr'){ return($first >> &keplet($third)); }
        if($second eq '+'){ return($first + &keplet($third)); }
        if($second eq '-'){ return($first - &keplet($third)); }
        if($second eq '*'){ return($first * &keplet($third)); }
        if($second eq '/'){ return($first / &keplet($third)); }
        if($second eq '%'){ return($first % &keplet($third)); }
    }
    elsif($trimmed =~ m(^\s*((?:-+\s*)*)((?:[_A-Za-z0-9]+|\$|'[^']+'|"[^"]+"))\s*)){
        #insert here TODO
        my $sign=$1;
        my $first=$2;
        $sign=(-1)**(split(/-/,$sign));
        if($first=~m/^[0-9]+$/){
            $first=$sign*$first;
        }
        elsif($first =~ m/^([0-9a-f]+h|0x[0-9a-f]+)$/i){
            $first=$sign*hex($first);
        }
        elsif($first =~ m/["'](.)/){
            $first=$sign*ord($1);
        }
        elsif($first =~ m/\$/){
            $first=$sign*$PC;
        }
        else{
            if((defined $Variable{$first}[1])and($Variable{$first}[1]==1)){
                $first=$sign*$Variable{$first}[0];
            }else{
                $Variable{$first}[0]=&keplet($Variable{$first}[2]);
                $Variable{$first}[1]=1;
                $first=$sign*$Variable{$first}[0];
            }
        }
        return($first);
    }
}

my %Ops0 = (
    'NOP' => 0,
    'STAX\s+B' => 2,
    'INX\s+B' => 3,
    'INR\s+B' => 4,
    'DCR\s+B' => 5,
    'RLC' => 7,
    'DAD\s+B' => 9,
    'LDAX\s+B' => 0xA,
    'DCX\s+B' => 0xB,
    'INR\s+C' => 0xC ,
    'DCR\s+C' => 0xD,
    'RRC' => 0xF,
    'STAX\s+D' => 0x12,
    'INX\s+D' => 0x13,
    'INR\s+D' => 0x14,
    'DCR\s+D' => 0x15,
    'RAL' => 0x17,
    'DAD\s+D' => 0x19,
    'LDAX\s+D' => 0x1A,
    'DCX\s+D' => 0x1B,
    'INR\s+E' => 0x1C,
    'DCR\s+E' => 0x1D,
    'RAR' => 0x1F,
    'RIM' => 0x20,
    'INX\s+H' => 0x23,
    'INR\s+H' => 0x24,
    'DCR\s+H' => 0x25,
    'DAA' => 0x27,
    'DAD\s+H' => 0x29,
    'DCX\s+H' => 0x2B,
    'INR\s+L' => 0x2C,
    'DCR\s+L' => 0x2D,
    'CMA' => 0x2F,
    'SIM' => 0x30,
    'INX\s+SP' => 0x33,
    'INR\s+M' => 0x34,
    'DCR\s+M' => 0x35,
    'STC' => 0x37,
    'DAD\s+SP' => 0x39,
    'DCX\s+SP' => 0x3B,
    'INR\s+A' => 0x3C,
    'DCR\s+A' => 0x3D,
    'CMC' => 0x3F,
    'MOV\s+B\s*,\s*B' => 0x40,
    'MOV\s+B\s*,\s*C' => 0x41,
    'MOV\s+B\s*,\s*D' => 0x42,
    'MOV\s+B\s*,\s*E' => 0x43,
    'MOV\s+B\s*,\s*H' => 0x44,
    'MOV\s+B\s*,\s*L' => 0x45,
    'MOV\s+B\s*,\s*M' => 0x46,
    'MOV\s+B\s*,\s*A' => 0x47,
    'MOV\s+C\s*,\s*B' => 0x48,
    'MOV\s+C\s*,\s*C' => 0x49,
    'MOV\s+C\s*,\s*D' => 0x4A,
    'MOV\s+C\s*,\s*E' => 0x4B,
    'MOV\s+C\s*,\s*H' => 0x4C,
    'MOV\s+C\s*,\s*L' => 0x4D,
    'MOV\s+C\s*,\s*M' => 0x4E,
    'MOV\s+C\s*,\s*A' => 0x4F,
    'MOV\s+D\s*,\s*B' => 0x50,
    'MOV\s+D\s*,\s*C' => 0x51,
    'MOV\s+D\s*,\s*D' => 0x52,
    'MOV\s+D\s*,\s*E' => 0x53,
    'MOV\s+D\s*,\s*H' => 0x54,
    'MOV\s+D\s*,\s*L' => 0x55,
    'MOV\s+D\s*,\s*M' => 0x56,
    'MOV\s+D\s*,\s*A' => 0x57,
    'MOV\s+E\s*,\s*B' => 0x58,
    'MOV\s+E\s*,\s*C' => 0x59,
    'MOV\s+E\s*,\s*D' => 0x5A,
    'MOV\s+E\s*,\s*E' => 0x5B,
    'MOV\s+E\s*,\s*H' => 0x5C,
    'MOV\s+E\s*,\s*L' => 0x5D,
    'MOV\s+E\s*,\s*M' => 0x5E,
    'MOV\s+E\s*,\s*A' => 0x5F,
    'MOV\s+H\s*,\s*B' => 0x60,
    'MOV\s+H\s*,\s*C' => 0x61,
    'MOV\s+H\s*,\s*D' => 0x62,
    'MOV\s+H\s*,\s*E' => 0x63,
    'MOV\s+H\s*,\s*H' => 0x64,
    'MOV\s+H\s*,\s*L' => 0x65,
    'MOV\s+H\s*,\s*M' => 0x66,
    'MOV\s+H\s*,\s*A' => 0x67,
    'MOV\s+L\s*,\s*B' => 0x68,
    'MOV\s+L\s*,\s*C' => 0x69,
    'MOV\s+L\s*,\s*D' => 0x6A,
    'MOV\s+L\s*,\s*E' => 0x6B,
    'MOV\s+L\s*,\s*H' => 0x6C,
    'MOV\s+L\s*,\s*L' => 0x6D,
    'MOV\s+L\s*,\s*M' => 0x6E,
    'MOV\s+L\s*,\s*A' => 0x6F,
    'MOV\s+M\s*,\s*B' => 0x70,
    'MOV\s+M\s*,\s*C' => 0x71,
    'MOV\s+M\s*,\s*D' => 0x72,
    'MOV\s+M\s*,\s*E' => 0x73,
    'MOV\s+M\s*,\s*H' => 0x74,
    'MOV\s+M\s*,\s*L' => 0x75,
    'HLT' => 0x76,
    'MOV\s+M\s*,\s*A' => 0x77,
    'MOV\s+A\s*,\s*B' => 0x78,
    'MOV\s+A\s*,\s*C' => 0x79,
    'MOV\s+A\s*,\s*D' => 0x7A,
    'MOV\s+A\s*,\s*E' => 0x7B,
    'MOV\s+A\s*,\s*H' => 0x7C,
    'MOV\s+A\s*,\s*L' => 0x7D,
    'MOV\s+A\s*,\s*M' => 0x7E,
    'MOV\s+A\s*,\s*A' => 0x7F,
    'ADD\s+B' => 0x80,
    'ADD\s+C' => 0x81,
    'ADD\s+D' => 0x82,
    'ADD\s+E' => 0x83,
    'ADD\s+H' => 0x84,
    'ADD\s+L' => 0x85,
    'ADD\s+M' => 0x86,
    'ADD\s+A' => 0x87,
    'ADC\s+B' => 0x88,
    'ADC\s+C' => 0x89,
    'ADC\s+D' => 0x8A,
    'ADC\s+E' => 0x8B,
    'ADC\s+H' => 0x8C,
    'ADC\s+L' => 0x8D,
    'ADC\s+M' => 0x8E,
    'ADC\s+A' => 0x8F,
    'SUB\s+B' => 0x90,
    'SUB\s+C' => 0x91,
    'SUB\s+D' => 0x92,
    'SUB\s+E' => 0x93,
    'SUB\s+H' => 0x94,
    'SUB\s+L' => 0x95,
    'SUB\s+M' => 0x96,
    'SUB\s+A' => 0x97,
    'SBB\s+B' => 0x98,
    'SBB\s+C' => 0x99,
    'SBB\s+D' => 0x9A,
    'SBB\s+E' => 0x9B,
    'SBB\s+H' => 0x9C,
    'SBB\s+L' => 0x9D,
    'SBB\s+M' => 0x9E,
    'SBB\s+A' => 0x9F,
    'ANA\s+B' => 0xA0,
    'ANA\s+C' => 0xA1,
    'ANA\s+D' => 0xA2,
    'ANA\s+E' => 0xA3,
    'ANA\s+H' => 0xA4,
    'ANA\s+L' => 0xA5,
    'ANA\s+M' => 0xA6,
    'ANA\s+A' => 0xA7,
    'XRA\s+B' => 0xA8,
    'XRA\s+C' => 0xA9,
    'XRA\s+D' => 0xAA,
    'XRA\s+E' => 0xAB,
    'XRA\s+H' => 0xAC,
    'XRA\s+L' => 0xAD,
    'XRA\s+M' => 0xAE,
    'XRA\s+A' => 0xAF,
    'ORA\s+B' => 0xB0,
    'ORA\s+C' => 0xB1,
    'ORA\s+D' => 0xB2,
    'ORA\s+E' => 0xB3,
    'ORA\s+H' => 0xB4,
    'ORA\s+L' => 0xB5,
    'ORA\s+M' => 0xB6,
    'ORA\s+A' => 0xB7,
    'CMP\s+B' => 0xB8,
    'CMP\s+C' => 0xB9,
    'CMP\s+D' => 0xBA,
    'CMP\s+E' => 0xBB,
    'CMP\s+H' => 0xBC,
    'CMP\s+L' => 0xBD,
    'CMP\s+M' => 0xBE,
    'CMP\s+A' => 0xBF,
    'RNZ' => 0xC0,
    'POP\s+B' => 0xC1,
    'PUSH\s+B' => 0xC5,
    'RST\s+0' => 0xC7,
    'RZ' => 0xC8,
    'RET' => 0xC9,
    'RST\s+1' => 0xCF,
    'RNC' => 0xD0,
    'POP\s+D' => 0xD1,
    'PUSH\s+D' => 0xD5,
    'RST\s+2' => 0xD7,
    'RC' => 0xD8,
    'RST\s+3' => 0xDF,
    'RPO' => 0xE0,
    'POP\s+H' => 0xE1,
    'XTHL' => 0xE3,
    'PUSH\s+H' => 0xE5,
    'RST\s+4' => 0xE7,
    'RPE' => 0xE8,
    'PCHL' => 0xE9,
    'XCHG' => 0xEB,
    'RST\s+5' => 0xEF,
    'RP' => 0xF0,
    'POP\s+PSW' => 0xF1,
    'DI' => 0xF3,
    'PUSH\s+PSW' => 0xF5,
    'RST\s+6' => 0xF7,
    'RM' => 0xF8,
    'SPHL' => 0xF9,
    'EI' => 0xFB,
    'RST\s+7' => 0xFF,
);

my %Ops8 = (
    'MVI\s+B\s*,\s*(.*)' => 0x6,
    'MVI\s+C\s*,\s*(.*)' => 0xE,
    'MVI\s+D\s*,\s*(.*)' => 0x16,
    'MVI\s+E\s*,\s*(.*)' => 0x1E,
    'MVI\s+H\s*,\s*(.*)' => 0x26,
    'MVI\s+L\s*,\s*(.*)' => 0x2E,
    'MVI\s+M\s*,\s*(.*)' => 0x36,
    'MVI\s+A\s*,\s*(.*)' => 0x3E,
    'ADI\s+(.*)' => 0xC6,
    'ACI\s+(.*)' => 0xCE,
    'OUT\s+(.*)' => 0xD3,
    'SUI\s+(.*)' => 0xD6,
    'IN\s+(.*)' => 0xDB,
    'SBI\s+(.*)' => 0xDE,
    'ANI\s+(.*)' => 0xE6,
    'XRI\s+(.*)' => 0xEE,
    'ORI\s+(.*)' => 0xF6,
    'CPI\s+(.*)' => 0xFE,
);

my %Ops16 = (
    'LXI\s+B\s*,\s*(.*)' => 0x1,
    'LXI\s+D\s*,\s*(.*)' => 0x11,
    'LXI\s+H\s*,\s*(.*)' => 0x21,
    'LXI\s+SP\s*,\s*(.*)' => 0x31,
    'SHLD\s+(.*)' => 0x22,
    'LHLD\s+(.*)' => 0x2A,
    'STA\s+(.*)' => 0x32,
    'LDA\s+(.*)' => 0x3A,
    'JNZ\s+(.*)' => 0xC2,
    'JMP\s+(.*)' => 0xC3,
    'CNZ\s+(.*)' => 0xC4,
    'JZ\s+(.*)' => 0xCA,
    'CZ\s+(.*)' => 0xCC,
    'CALL\s+(.*)' => 0xCD,
    'JNC\s+(.*)' => 0xD2,
    'CNC\s+(.*)' => 0xD4,
    'JC\s+(.*)' => 0xDA,
    'CC\s+(.*)' => 0xDC,
    'JPO\s+(.*)' => 0xE2,
    'CPO\s+(.*)' => 0xE4,
    'JPE\s+(.*)' => 0xEA,
    'CPE\s+(.*)' => 0xEC,
    'JP\s+(.*)' => 0xF2,
    'CP\s+(.*)' => 0xF4,
    'JM\s+(.*)' => 0xFA,
    'CM\s+(.*)' => 0xFC,
);

# main()
my $aout = 'a.out';
my $ain = '-';
my $alist = '';
my $helptext = "\nCall\n\n\t$0 -h\n\nfor more details\n";
while($#ARGV>=0){
    my $param = shift;
    if($param eq '-h'){
        print "
Usage:

$0 -h                                   This help text
$0 [-o OUTPUTFILE.bin] <INPUTFILE.asm>  Compile input file to 8085 binary

";
        exit 0;
    }
    elsif($param eq '-o'){
        $aout = shift or die("\nERROR: Wrong name for output file!\n$helptext\n");}
    elsif($param eq '--xref'){
        $alist = shift or die("\nERROR: Wrong name forx xref file!\n$helptext\n");}
    elsif($#ARGV==-1){
        $ain = $param;}
    else{
        die("\nERROR: Wrong number of arguments!\n$helptext\n");}}

open(F,'<',$ain) or die("\nERROR: Cannot open '$ain' for input!\n$helptext\n");
open(G,'>',$aout) or die("\nERROR: Cannot open '$aout' for output!\n\n");
my @lines;
while(my $line=<F>){
    last if($line =~ m/^\s*END\s*(;.*)?$/i);
    $line =~ s/\s+$//;
    chomp($line);
    my $quote=0;
    my $tobesaved='';
    for(my $i=0;$i<length($line);$i++){
        if($quote==0){
            if(substr($line,$i,1) eq ';'){last;}
            elsif(substr($line,$i,1) eq "'"){$quote=1;}
            elsif(substr($line,$i,1) eq '"'){$quote=2;}
            if(substr($line,$i,1) =~ /\S/){
                if(($i>0)
                and(substr($line,$i-1,1)=~/\s/)
                and($tobesaved !~ m/[,: ]$/)
                and($tobesaved =~ m/\S/)
                ){$tobesaved = $tobesaved . ' ';}
                $tobesaved = $tobesaved . substr($line,$i,1);
            }
        }elsif($quote==1){
            if(substr($line,$i,1) eq "'"){$quote=0;}
            $tobesaved = $tobesaved . substr($line,$i,1);
        }else{
            if(substr($line,$i,1) eq '"'){$quote=0;}
            $tobesaved = $tobesaved . substr($line,$i,1);
        }
    }
    push @lines,$tobesaved if($tobesaved =~ /\S/);
}
close(F);
# to do the rest.
#foreach my $i (@lines){print G "$i\n";}
#close(G);
my $EntryPoint=65536;
my @Code=();
for(my $i=0;$i<65536;++$i){$Code[$i]=0;}
our $PC=0;
my $FullLength=0;
my $MaxPC = 0;
foreach my $i (@lines) {
    last if($i =~ m/^\s*END\s*(;.*)?$/i);
    while($i =~ m/\s*(\S+):/g){
        $Variable{$1}[0]=$PC;$Variable{$1}[1]=1;$Variable{$1}[2]="$1".'.';
    }
    $i =~ s/(\s*\S+:)\s*//g;
    if($i=~m/\S/){
        if($i=~m/^\s*(\S+)\s+EQU\s+(.*?)\s*$/i){
            $Variable{$1}[0]=&keplet($2);$Variable{$1}[1]=1;$Variable{$1}[2]=$2;
        }
        elsif($i=~m/^\s*ORG\s+(\S+)\s*$/i){$PC=&keplet($1);if($EntryPoint>$PC){$EntryPoint=$PC;}}
        elsif($i=~m/^\s*DS\s+(\S+)\s*$/i){my $j=&keplet($1);if($EntryPoint>$PC){$EntryPoint=$PC;}$PC+=$j;}
        elsif($i=~m/^\s*DB\s+(.*?)\s*$/i){ # DB length count!
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            my $DBarg=','.$1;
            my $DBlen=0;
            my $quote=0;
            for(my $j=0;$j<length($DBarg);$j++){
                 if($quote==0){
                      if(substr($DBarg,$j) =~ m/^(,\s*)'[^'][^'']/){$j+=length($1);$quote=1;}
                      elsif(substr($DBarg,$j) =~ m/^(,\s*)"[^"][^""]/){$j+=length($1);$quote=2;}
                      else{
                          if((substr($DBarg,$j)=~m/^(,\s*([^,]+))/)){
                          my $tmplength=length($1);
                          #$Code[$PC+$DBlen]=0xFF & &keplet($2);
                          $j+=$tmplength-1;
                          ++$DBlen;}
                      }
                 }
                 elsif($quote==1){
                     if(substr($DBarg,$j,1) eq "'"){
                         $quote=0;}
                     else{
                         #$Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         ++$DBlen;}}
                 elsif($quote==2){
                     if(substr($DBarg,$j,1) eq '"'){
                         $quote=0;}
                     else{
                         #$Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         ++$DBlen;}}
            }
            $PC+=$DBlen;
        }
        elsif($i=~m/^\s*DW\s+(.*?)\s*$/i){ # DW length count!
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            my $DBarg=','.$1;
            my $DBlen=0;
            my $quote=0;
            for(my $j=0;$j<length($DBarg);$j++){
                 if($quote==0){
                      if(substr($DBarg,$j) =~ m/^(,\s*)'[^'][^'']/){$j+=length($1);$quote=1;}
                      elsif(substr($DBarg,$j) =~ m/^(,\s*)"[^"][^""]/){$j+=length($1);$quote=2;}
                      else{
                          if((substr($DBarg,$j)=~m/^(,\s*([^,]+))/)){
                          my $tmplength=length($1);
                          #my $tmpkeplet = &keplet($2);
                          #$Code[$PC+$DBlen]=0xFF & $tmpkeplet;
                          #$Code[$PC+$DBlen+1]=(0xFF00 & $tmpkeplet)>>8;
                          $j+=$tmplength-1;
                          $DBlen+=2;}
                      }
                 }
                 elsif($quote==1){
                     if(substr($DBarg,$j,1) eq "'"){
                         $quote=0;}
                     else{
                         #$Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         #$Code[$PC+$DBlen+1]=0;
                         $DBlen+=2;}}
                 elsif($quote==2){
                     if(substr($DBarg,$j,1) eq '"'){
                         $quote=0;}
                     else{
                         #$Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         #$Code[$PC+$DBlen+1]=0;
                         $DBlen+=2;}}
            }
            $PC+=$DBlen;
        }
        elsif($i=~m/^\s*(RIM|SIM|HLT|NOP|RLC|RAL|DAA|STC|RRC|RAR|CMA|CMC|RN?[CZ]|RPO|RPE|RP|RM|XTHL|DI|XCHG|EI|RET|PCHL|SPHL)\s*$/i){
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            $PC++;
        }
        elsif($i=~m/^\s*(STAX|LDAX|INX|DCX|DAD|INR|DCR|MOV|ADD|ADC|SUB|SBB|ANA|XRA|ORA|CMP|POP|PUSH|RST)($|\s.*)/i){
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            $PC++;
        }
        elsif($i=~m/^\s*(MVI|OUT|IN|ADI|ACI|SUI|SBI|ANI|XRI|ORI|CPI)($|\s.*)/i){
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            $PC+=2;
        }
        elsif($i=~m/^\s*(LXI|SHLD|LHLD|STA|LDA|[CJ]N?[CZ]|[CJ]P[OE]|[CJ][PM]|CALL|JMP)($|\s.*)/i){
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            $PC+=3;
        }
        $MaxPC = $MaxPC<$PC ? $PC : $MaxPC;
    }
} # LABELS are evaluated, first stage of compiling is ready.

$PC=0;
foreach my $i (@lines) {
    last if($i =~ m/^\s*END\s*(;.*)?$/i);
    $i =~ s/(\s*\S+:)\s*//g; # labels deleted
    if($i=~m/\S/){
        if($i=~m/^\s*(\S+)\s+EQU\s+(.*?)\s*$/i){
            unless($Variable{$1}[1]==1){$Variable{$1}[0]=&keplet($2);$Variable{$1}[1]=1;$Variable{$1}[2]=$2;}
        }
        elsif($i=~m/^\s*ORG\s+(\S+)\s*$/i){$PC=&keplet($1);if($EntryPoint>$PC){$EntryPoint=$PC;}}
        elsif($i=~m/^\s*DS\s+(\S+)\s*$/i){
              my $j=&keplet($1);
              if($EntryPoint>$PC){$EntryPoint=$PC;}
              $PC+=$j;
              $FullLength+=$j;}
        # TODO DB, DW, statements
        elsif($i=~m/^\s*DB\s+(.*?)\s*$/i){ # DB length count!
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            my $DBarg=','.$1;
            my $DBlen=0;
            my $quote=0;
            for(my $j=0;$j<length($DBarg);$j++){
                 if($quote==0){
                      if(substr($DBarg,$j) =~ m/^(,\s*)'[^'][^'']/){$j+=length($1);$quote=1;}
                      elsif(substr($DBarg,$j) =~ m/^(,\s*)"[^"][^""]/){$j+=length($1);$quote=2;}
                      else{
                          if((substr($DBarg,$j)=~m/^(,\s*([^,]+))/)){
                          my $tmplength=length($1);
                          $Code[$PC+$DBlen]=0xFF & &keplet($2);
                          $j+=$tmplength-1;
                          ++$DBlen;}
                      }
                 }
                 elsif($quote==1){
                     if(substr($DBarg,$j,1) eq "'"){
                         $quote=0;}
                     else{
                         $Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         ++$DBlen;}}
                 elsif($quote==2){
                     if(substr($DBarg,$j,1) eq '"'){
                         $quote=0;}
                     else{
                         $Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         ++$DBlen;}}
            }
            $PC+=$DBlen;
        }
        elsif($i=~m/^\s*DW\s+(.*?)\s*$/i){ # DW length count!
            if($EntryPoint>$PC){$EntryPoint=$PC;}
            my $DBarg=','.$1;
            my $DBlen=0;
            my $quote=0;
            for(my $j=0;$j<length($DBarg);$j++){
                 if($quote==0){
                      if(substr($DBarg,$j) =~ m/^(,\s*)'[^'][^'']/){$j+=length($1);$quote=1;}
                      elsif(substr($DBarg,$j) =~ m/^(,\s*)"[^"][^""]/){$j+=length($1);$quote=2;}
                      else{
                          if((substr($DBarg,$j)=~m/^(,\s*([^,]+))/)){
                          my $tmplength=length($1);
                          my $tmpkeplet = &keplet($2);
                          $Code[$PC+$DBlen]=0xFF & $tmpkeplet;
                          $Code[$PC+$DBlen+1]=(0xFF00 & $tmpkeplet)>>8;
                          $j+=$tmplength-1;
                          $DBlen+=2;}
                      }
                 }
                 elsif($quote==1){
                     if(substr($DBarg,$j,1) eq "'"){
                         $quote=0;}
                     else{
                         $Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         $Code[$PC+$DBlen+1]=0;
                         $DBlen+=2;}}
                 elsif($quote==2){
                     if(substr($DBarg,$j,1) eq '"'){
                         $quote=0;}
                     else{
                         $Code[$PC+$DBlen]=ord(substr($DBarg,$j,1));
                         $Code[$PC+$DBlen+1]=0;
                         $DBlen+=2;}}
            }
            $PC+=$DBlen;
        }
        else {
            # foreach key statements
            my $isdone = 0;
            foreach my $k (keys %Ops0) {
                last if ($isdone == 1);
                if($i =~ m/^\s*$k/i){$isdone=1;$Code[$PC]=$Ops0{$k};++$PC;}
            }
            foreach my $k (keys %Ops8) {
                last if ($isdone == 1);
                if($i =~ m/^\s*$k/i){$Code[$PC+1]=0xFF & (&keplet($1));
                                    $isdone=1;
                                    $Code[$PC]=$Ops8{$k};
                                    $PC+=2;}
            }
            foreach my $k (keys %Ops16) {
                last if ($isdone == 1);
                if($i =~ m/^\s*$k/i){my $tmp=&keplet($1);
                                    $Code[$PC+1]=0xFF & $tmp;
                                    $Code[$PC+2]=(0xFF00 & $tmp)>>8;
                                    $isdone=1;
                                    $Code[$PC]=$Ops16{$k};
                                    $PC+=3;}
            }
            if($isdone == 0){die("\nERROR: Unknown statement '$i'\n\n");}
        }
    }
}
for(my $i=$EntryPoint;$i<$MaxPC;++$i){
    print G chr($Code[$i] & 0xFF);
}
close(G);
if($alist ne ''){
    open(H,'>',$alist) or die("\nERROR: Cannot open '$alist' for xref!\n\n");
    foreach my $i (keys %Variable) {
        print H sprintf("%02x",($Variable{$i}[0] & 0xFF00) >> 8)," ",sprintf("%02x",$Variable{$i}[0] & 0xFF)," "," = $i\n";
    }
    close(H);
}
__END__
