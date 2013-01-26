use strict;
use warnings;
no warnings 'void';
use Oktest;
use utf8;

binmode STDOUT, ":utf8";
binmode STDERR, ":utf8";
binmode STDIN,  ":utf8";

topic "Test Class" => sub {
    topic "Test mothod" => sub {
        case_when "Case A", => sub {
            spec "specification" => sub {
            };
        };
        case_when "Case B", => sub {
            spec "specification" => sub {
            };
        };
    };
};

Oktest::main();
