package Alien::Base::Dino;

use strict;
use warnings;
use 5.008001;
use base qw( Alien::Base );
use Role::Tiny::With ();

Role::Tiny::With::with('Alien::Role::Dino');

# ABSTRACT: Experimental support for dynamic share Alien install
# VERSION

=head1 SYNOPSIS

In your L<alienfile>:

 use alienfile;
 
 share {
   ...
   plugin 'Gather::Dino';
 }

Then instead of subclassing L<Alien::Base>:

 package Alien::libfoo;
 
 use base qw( Alien::Base::Dino );
 
 1;

And finally from the .pm side of your XS module:

 package Foo::XS;
 
 use Alien::libfoo;
 
 our $VERSION = '1.00';
 
 # Note caveat: your Alien is now a run-time
 # dependency of your XS module.
 Alien::libfoo->xs_load(__PACKAGE__, $VERSION);
 
 1;

=head1 DESCRIPTION

This is a subclass of L<Alien::Base> with the L<Alien::Role::Dino> role
already applied.  You shouldn't use it directly.  Making this a subclass
instead of a role was a mistake, and this class will be removed in the
near future.

=head1 BASE CLASS

This class is a subclass of L<Alien::Base> and as such, in inherits all
of its methods and properties.

=head1 SEE ALSO

=over 4

=item L<Alien::Role::Dino>

=back

=cut

1;
