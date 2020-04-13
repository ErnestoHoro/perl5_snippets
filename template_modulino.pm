# ==========================================================================\140
#  Name         Package::Reference
#
#               <description>
#
#  Author       <name> | <group>
#  Mail         <mail>
# ------------------------------------------------------------------------------
#  2077-01-01   <name> - <version>
# ==============================================================================

package Package::Reference;

use strict;
use warnings;

use lib '/include-1',
        '/include-2';

use Data::Dumper;
use Log::Log4perl;
use Pod::Usage;
use POSIX qw(strftime nice);

_init_logger();
my $Log = Log::Log4perl->get_logger(__PACKAGE__);

main() if not caller();


sub new {

    my $class = shift;

    my %args = @_;
    my %args_defaults = (
        'arg-1' => undef,
    );
    %args = (%args_defaults, %args);

    my $self = {
        'args'   => \%args,
        'result' => undef,
    };

    bless ($self, $class);
    return $self;

}

sub run {

    my $self = shift;

    # do stuff

    return $self;

}

sub get_result {

    my $self = shift;
    return $self->{'result'};

}

sub _init_logger {

    my $cdatetime = strftime("%y%m%d_%H%M%S", localtime);
    my $log_level = 'INFO';

    Log::Log4perl->init(\ <<"END");
    log4perl.logger = ${log_level}, Screen
    log4perl.appender.Screen = Log::Log4perl::Appender::ScreenColoredLevels
    log4perl.appender.Screen.layout = Log::Log4perl::Layout::PatternLayout
    log4perl.appender.Screen.layout.ConversionPattern = %d %p> %m%n
    log4perl.appender.Logfile = Log::Log4perl::Appender::File
    log4perl.appender.Logfile.autoflush = 1
    log4perl.appender.Logfile.filename = example_${cdatetime}.log
    log4perl.appender.Logfile.layout = Log::Log4perl::Layout::PatternLayout
    log4perl.appender.Logfile.layout.ConversionPattern = %d %p> %m%n
END

}

sub main {

    my $object = __PACKAGE__->new(
        'arg-1' => undef,
    );
    $object->run();
    my $result = $object->get_result();

}

1;
