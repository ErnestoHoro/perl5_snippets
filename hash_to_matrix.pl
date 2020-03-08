use v5.20.2;
use strict;
use warnings;

use Data::Dumper;


my %nested = (
    '1st-key' => '1st-val',
    '2nd-key' => {
        '1st-key-1st-nest' => '1st-val-1st-nest',
        '2nd-key-1st-nest' => '2nd-val-1st-nest',
        '3rd-key-1st-nest' => {
            '1st-key-2nd-nest' => {
                '1st-key-3rd-nest' => '1st-val-3rd-nest',
            },
        },
        '4th-key-1st-nest' => '4th-val-1st-nest',
    },
    '3rd-key' => '3rd-val',
);

sub hash_to_matrix {

    my (%hash) = @_;

    local our @matrix;
    local our $cols_count = 0;

    local our $cols = 0;
    local our $rows = 0;

    sub _hash_to_matrix {

        my (%_hash) = @_;

        my $col = $cols;

        foreach my $k (sort (keys(%_hash))) {
            my $v = $_hash{$k};

            if (ref($v) eq 'HASH') {
                $matrix[$rows][$col] = $k;

                $cols += 1;

                _hash_to_matrix(%{$v});
            }
            else {
                $matrix[$rows][$col] = $k;
                $matrix[$rows][$col + 1] = $v;

                my $cols_last = $col + 2;
                $cols_count = $cols_last if ($cols_last > $cols_count);

                $rows += 1;
            }
        }

    }

    _hash_to_matrix(%hash);

    return (\@matrix, $cols_count, $rows);

}

sub main {

    my ($matrix, $cols, $rows) = hash_to_matrix(%nested);

    print(Dumper($matrix) . "\n");
    print("Number of columns: $cols" . "\n");
    print("Number of rows:    $rows" . "\n");

}

main();
