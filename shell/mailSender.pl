#!/usr/bin/perl -w
# mail-attachment - send files as attachments
use iBase '-base';
use MIME::Lite;
use Getopt::Std;
 
my $SMTP_SERVER = 'localhost:smtp';
my $DEFAULT_SENDER = 'jack.zhang@linuxbox.com';
my $DEFAULT_RECIPIENT = 'jzhangkun1986@gmail.com';
 
MIME::Lite->send('smtp', $SMTP_SERVER, Timeout=>60);
 
my (%o, $msg);
 
# process options
 
getopts('hf:t:s:c:', \%o);
 
$o{f} ||= $DEFAULT_SENDER;
$o{t} ||= $DEFAULT_RECIPIENT;
$o{s} ||= 'Your binary file, sir';
 
if ($o{h} or !@ARGV) {
    die "usage:\n\t$0 [-h] [-f from] [-t to] [-s subject] file ...\n";
}
 
# construct and send email
 
$msg = new MIME::Lite(
    From => $o{f},
    To   => $o{t},
    Subject => $o{s},
    Data => "Hi",
    Type => "multipart/mixed",
);

$msg->add(Cc => $o{c}) if exists $o{c};
 
for (@ARGV) {
    next unless -f;
    $msg->attach('Type' => 'application/octet-stream',
                 'Encoding' => 'base64',
                 'Path' => $_);
}
 
$msg->send();

print "mail sent at ", scalar localtime, "\n";
