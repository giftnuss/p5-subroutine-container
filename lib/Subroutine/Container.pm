  package Subroutine::Container
# *****************************
; our $VERSION='0.100'
# ********************
; use strict
; use warnings

; use Carp

; sub new
    { my ($class)=@_
    ; $class = ref $class if ref $class
    ; bless {} , $class
    }

; sub insert
    { my ($self,$key,$sub,@args)=@_
    ; return if $self->exists($key)
    ; $self->{$key}=&$sub( @args )
    }

; sub insert_always
    { my ($self,$key,$sub,@args)=@_
    ; $self->{$key}=&$sub( @args )
    }

; sub exists
    { my ($self,$key)=@_
    ; CORE::exists $self->{$key}
    }

; sub take
    { my ($self,$key,@par)=@_
    ; unless( $self->exists($key) )
        { carp "$key isn't in the chest."
        ; return 
        }			   
    ; &{$self->{$key}}(@par);
    }

; 1

__END__

=head1 NAME

Subroutine::Container - Class to store procedures in a hash

=head1 SYNOPSIS

  ; use Subroutine::Container
  
  ; my $c = Subroutine::Container->new
  
  ; sub hello 
      { $val={ 'de' => 'hallo', 'en' => 'hello' }->{shift()} 
      ; sub { my $pers=shift; ucfirst($val)." ".$pers } 
      }
            
  ; $c->insert("hello world",\&hello, "de")
  
  ; print $chest->take("hello world","Welt")
  
=head1 DESCRIPTION

This is a simple interface to call subroutines by strings. So
it is easy to have longer but readable function calls or totally 
cryptical ones.

=head1 USAGE

=head2 C<new>

A simple Constructor for a hash based object.

=head2 C<insert>

  ; $chest->insert("name",sub{my $a=$_[0];sub{$a}},"name")

Important is the second method argument. It's used to be a valid code reference
with another code reference as return value. This code ref is then stored under 
the value from first argument. If an entry exists under this name, this method 
does nothing. Additional arguments will be used when the second argument
is executed.

=head2 C<insert_always>

Same as above but overwrites existing entries.

=head2 C<exists>

Check if an an entry with a given name exists.

=head2 C<take>

Execute a stored subroutine with the given arguments.


=head1 SEE ALSO

L<Callback>

=head1 TODO

Getting feedback and correct all mistakes in code and documentation.

=head1 AUTHOR

Sebastian Knapp 

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006,2017 by Sebastian Knapp

This library is free software; you can redistribute it and/or modify
it under the same terms as perl itself.

=cut


