  package Subroutine::Container::Contractual;
# ******************************************
  our $VERSION = '0.100';
# ***********************
  use strict; use warnings
; use parent 'Subroutine::Container'

; use Carp
#; $Carp::CarpLevel = 2;
; use Data::Dumper

# key to save the actual chest function
; use constant PERFORM => 0
# key under which a function to check input parameters can be registered
; use constant REQUIRE => 1
# key under which a function to check the return value can be registered
; use constant ENSURE  => 2

; sub insert_always
    { my ($self,$key,$code,@args)=@_
    ; local $_
    ; my $entry=$self->{$key} || []
    ; my @parts=qw/perform require ensure/

    ; for ( 0..$#parts )
        { if( defined($code->{$parts[$_]}) )
            { $entry->[$_] = &{$code->{$parts[$_]}}(@args)
            ; unless( ref $entry->[$_] eq 'CODE' )
                { print Dumper($entry)
                ; croak uc($_)." is no sub"
                }
            }
        }
    ; $self->{$key}=$entry
    }

; sub exists
    { my ($self,$key)=@_
    ; CORE::exists $self->{$key}
    }

; sub take
    { my ($self,$key,@par)=@_
    ; unless( $self->exists($key)  )
        { carp "$key isn't in the chest."
        ; return undef
        }
    ; unless( ref $self->{$key}->[PERFORM] eq "CODE" )
        { carp "no code to perform for key $key."
        }

    ; if( CORE::exists($self->{$key}->[REQUIRE]) )
        { unless( &{$self->{$key}->[REQUIRE]}(@par) )
            { carp "Failure during check of arguments for $key."
            ; return undef
        }   }

    ; return &{$self->{$key}->[PERFORM]}(@par)
        unless CORE::exists($self->{$key}->[ENSURE])

    ; if( wantarray )
        { my @result = &{$self->{$key}->[PERFORM]}(@par)
        ; if( CORE::exists($self->{$key}->[ENSURE]) )
            { my @temp = &{$self->{$key}->[ENSURE]}(@result)
            ; unless( @temp && $temp[0] )
                { carp "Failure during check of result from $key."
                ; return ()
                }
            }
        ; return @result
        }
      else
        { my $result = &{$self->{$key}->[PERFORM]}(@par)
        ; if( CORE::exists($self->{$key}->[ENSURE]) )
            { unless( &{$self->{$key}->[ENSURE]}($result) )
                { carp "Failure during check of result from $key."
                ; return undef
                }
            }
        ; return $result
        }
    }

; 1

__END__


