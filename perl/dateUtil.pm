package dateUtil;
use iBase;
use Time::Local qw(timegm);
use POSIX qw(strftime);

sub date_to_iso8601 {
    my $epoch;
    if ($_[0] =~ m{(\d{4})\/(\d{2})\/(\d{2}) (\d{2}):(\d{2}):(\d{2})}) {
        #Date Format as 'yyyy/mm/dd hh24:mi:ss'
        $epoch = timegm($6, $5, $4, $3, $2-1, $1-1900);
    }
    return unless $epoch;
    (my $tz = strftime("%z", localtime($epoch))) =~ s/(\d\d)(\d\d)/$1:$2/;
    return strftime("%Y-%m-%dT%H:%M:%S", localtime($epoch)) . $tz;

}

1;
