require 'benchmark'

total = ENV['TOTAL'] || 1_000_000

total = total.to_i

per = 2

puts "Control: 1m loops accessing a local variable 100 times"
per.times {
  puts Benchmark.measure {
    a = 5; 
    i = 0;
    while i < total
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      a; a; a; a; a; a; a; a; a; a;
      i += 1;
    end
  }
}

puts "Control 2: 1m loops accessing nil 100 times"
per.times {
  puts Benchmark.measure {
    a = 5; 
    i = 0;
    while i < total
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      nil; nil; nil; nil; nil; nil; nil; nil; nil; nil;
      i += 1;
    end
  }
}

puts "Test fastmath: 250k loops accessing a fixnum var and calling + 1"
per.times {
  puts Benchmark.measure {
    a = 5; 
    i = 0;
    while i < total/4
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1; a + 1;
      i += 1;
    end
  }
}

class Fixnum
  alias :plus :+
end

puts "Test prim math: 250k loops accessing a fixnum var and calling plus(1)"
per.times {
  puts Benchmark.measure {
    a = 5; 
    i = 0;
    while i < total/4
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1); a.plus(1);
      i += 1;
    end
  }
}

cm = def foo
  self
end

=begin
puts "Test ruby method (prim): 250k loops calling self's foo 100 times"
per.times {
  puts Benchmark.measure {
    i = 0;
    while i < total/4
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      i += 1;
    end
  }
}

begin
  cm.primitive = nil
rescue
  puts "No .primitive available"
end
=end

puts "Test ruby method: 250k loops calling self's foo 100 times"
per.times {
  puts Benchmark.measure {
    i = 0;
    while i < total/4
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      foo; foo; foo; foo; foo; foo; foo; foo; foo; foo;
      i += 1;
    end
  }
}
