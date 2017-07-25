package Alien::Build::Plugin::Gather::Dino;

use strict;
use warnings;
use 5.008001;
use Alien::Build::Plugin;
use FFI::CheckLib qw( find_lib );
use Path::Tiny qw( path );

# ABSTRACT: Experimental support for dynamic share Alien install
# VERSION

=head1 SYNOPSIS

 use alienfile;
 plugin 'Gather::Dini';

=head1 DESCRIPTION

This L<alienfile> plugins find directories inside the share directory with dynamic libraries in them
for C<share> type installs.  This information is necessary at either build or run-time by XS modules.
For various reasons you are probably better off building static libraries instead.  For more detail
and rational see the runtime documentation L<Alien::Base::Dino>.

=head1 SEE ALSO

=over 4

=item L<Alien::Base::Dino>

=back

=cut

sub init
{
  my($self, $meta) = @_;
  
  $meta->after_hook(
    gather_share => sub {
      my($build) = @_;
      
      foreach my $path (map { path('.')->absolute->child($_) } qw( bin lib dynamic ))
      {
        next unless -d $path;
        if(find_lib(lib => '*', libpath => $path->stringify, systempath => []))
        {
          push @{ $build->runtime_prop->{rpath} }, $path->basename;
        }
      }
    },
  );
}

1;
