
; use Test::More tests => 1

  ; use Subroutine::Container
  
  ; my $c = Subroutine::Container->new
  
  ; sub hello 
      { $val={ 'de' => 'hallo', 'en' => 'hello' }->{shift()} 
      ; sub { my $pers=shift; ucfirst($val)." ".$pers } }
            
  ; $c->insert("hello world",\&hello, "de")
  
  ; is( $c->take("hello world","Welt"), "Hallo Welt" )
  
