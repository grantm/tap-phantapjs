#!perl -T

use Test::More;

# Mock up registration method
sub TAP::Parser::IteratorFactory::register_handler { };

use TAP::Parser::SourceHandler::PhanTAPJS;

ok(1, "Successfully loaded TAP::Parser::SourceHandler::PhanTAPJS via 'use'");

done_testing();
exit;
