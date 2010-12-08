package Padre::Plugin::Catalyst::Outline;
BEGIN {
  $Padre::Plugin::Catalyst::Outline::VERSION = '0.12';
}

# ABSTRACT: A Catalyst plugin outline

use strict;
use warnings;

use Padre::Wx ();
use Wx;

use base 'Wx::TreeCtrl';

sub new {
	my $class  = shift;
	my $plugin = shift;
	my $main   = Padre::Current->main;

	my $self = $class->SUPER::new(
		$main->right,
		-1,
		Wx::wxDefaultPosition,
		Wx::wxDefaultSize,
		Wx::wxTR_HIDE_ROOT | Wx::wxTR_SINGLE | Wx::wxTR_HAS_BUTTONS | Wx::wxTR_LINES_AT_ROOT
	);
	$self->SetIndent(10);
	$self->{force_next} = 0;

	Wx::Event::EVT_COMMAND_SET_FOCUS(
		$self, $self,
		sub {

			#			$self->on_tree_item_set_focus( $_[1] );
		},
	);

	# Double-click a function name
	Wx::Event::EVT_TREE_ITEM_ACTIVATED(
		$self, $self,
		sub {

			#			$self->on_tree_item_activated( $_[1] );
		}
	);

	$self->Hide;

	#    $self->Show;
	$main->right->show($self);
	$self->fill;

	return $self;
}

# fill() fills the TreeCtrl with information regarding the project
sub fill {
	my $self = shift;

	my $tree_ref = $self->update_tree;
	my $root = $self->AddRoot( 'Root', -1, -1, Wx::TreeItemData->new('Data') );
	$self->populate( $root, $tree_ref );
}

# update_tree() should return whatever it is we want it to fill the
# Catalyst side-panel (TreeCtrl) with, as a hash reference.
# TODO: I'm still wondering about this Outline. What would you like it
# to display?
sub update_tree {
	return {
		'Model' => {},
		'View'  => {
			'TT' => 1,
		},
		'Controller' => {
			'Root' => 1,
			'Foo'  => {
				'Bar' => 1,
			}
		},
		'Templates' => {
			'one.tt'   => 1,
			'two.tt'   => 1,
			'three.tt' => 1,
		},
	};
}

# receives a hash reference and populates tree (starting from $root node)
# with its sorted values, recursively
sub populate {
	my ( $self, $root, $tree_ref ) = (@_);

	foreach my $item ( sort keys %{$tree_ref} ) {
		my $node = $self->AppendItem( $root, $item, -1, -1, Wx::TreeItemData->new($item) );

		if ( ref $tree_ref->{$item} ) {
			$self->populate( $node, $tree_ref->{$item} );
		}
	}
}

sub gettext_label {
	Wx::gettext('Catalyst');
}


1;


__END__
=pod

=head1 NAME

Padre::Plugin::Catalyst::Outline - A Catalyst plugin outline

=head1 VERSION

version 0.12

=head1 AUTHORS

=over 4

=item *

Breno G. de Oliveira <garu@cpan.org>

=item *

Ahmad M. Zawawi <ahmad.zawawi@gmail.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Breno G. de Oliveira.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

