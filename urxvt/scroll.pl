use List::Util qw(min max);

sub on_user_command {
    my ($term, $command) = @_;
    my $page_height = $term->nrow - 1;
    my $current_line = $term->view_start;
    my $new_line;

    for ($command) {

        /^pageup$/ and do {
        $new_line = max($current_line-$page_height, $term->top_row);
        };

        /^pagedown$/ and do {
        $new_line = min($current_line+$page_height, 0);
        };
    }

    $term->view_start($new_line);
    $term->want_refresh;
}
