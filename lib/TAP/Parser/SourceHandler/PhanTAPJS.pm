package TAP::Parser::SourceHandler::PhanTAPJS;

=head1 NAME

TAP::Parser::SourceHandler::PhanTAPJS - Runs Javascript programs to get their TAP for prove

=cut

use warnings;
use strict;

use parent 'TAP::Parser::SourceHandler';

TAP::Parser::IteratorFactory->register_handler(__PACKAGE__);


sub can_handle {
    my($class, $source) = @_;

    my $meta = $source->meta;
    my $config = $source->config_for( 'PhanTAPJS' );

    return 0 unless $meta->{is_file};

    my $suf = $meta->{file}{lc_ext};

    my $wanted_extension = $config->{extension} || '.js';

    return 1 if $suf eq $wanted_extension;

    return 0;
}


sub make_iterator {
    my($class, $source) = @_;
    my $config = $source->config_for('PhanTAPJS');

    my @command = ( $config->{phantap} || 'phantap' );

    my $fn = ref $source->raw ? ${ $source->raw } : $source->raw;
    push( @command, $fn );

    return TAP::Parser::Iterator::Process->new( {
        command => \@command,
        merge   => $source->merge
    });
}


1;

__END__


=head1 SYNOPSIS

This module is a plugin to let you use C<prove> to run test scripts written
in Javascript.  It uses PhantomJS (headless webkit) and the phantap.js test builder library.

    prove --source Perl --ext .t --source PhanTAPJS --ext .js t


=head1 DESCRIPTION

This plugin allows you to write test scripts in Javascript and have them be run
by C<prove> alongside test scripts written in Perl and other languages.

The plugin assumes you have installed:

=over 4

=item *

PhantomJS (L<http://phantomjs.org/>) - scriptable, headless, WebKit

=item *

phantap.js (L<https://github.com/shoptime/phantom-testlib) - a Javascript
library for TAP generation and scripted browser interactions

=back


=head1 METHODS

The following two methods implement the L<TAP::Parser::SourceHandler> API as
required by L<TAP::Source> in the L<Test::Harness> distribution:

=over 4

=item can_handle

Registers as a handler for files with a C<.js> extension.

=item make_iterator

Arranges for execution of .js files to be delegated to the C<phantap>
command.

=back

=head1 BUGS

Please report any bugs or feature requests to
C<bug-TAP::Parser::SourceHandler::PhanTAPJS at rt.cpan.org>, or through the web
interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=TAP::Parser::SourceHandler::PhanTAPJS>.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc TAP::Parser::SourceHandler::PhanTAPJS

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=TAP::Parser::SourceHandler::PhanTAPJS>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/TAP::Parser::SourceHandler::PhanTAPJS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/TAP::Parser::SourceHandler::PhanTAPJS>

=item * Search CPAN

L<http://search.cpan.org/dist/TAP::Parser::SourceHandler::PhanTAPJS/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT AND LICENSE

Copyright 2012 Grant McLean C<< <grantm@cpan.org> >>

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

