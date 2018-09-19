# This module is adapted from
# https://github.com/AllenDowney/ThinkPython2/blob/master/code/structshape.py
#
# This module provides one method, structshape, which takes an object
# of Array/Set/Hash type and returns a string that summarizes the
# "shape" of the data structure; that is, the type, size and composition.

require 'set'

def structshape(ds)
  # Returns a string that describes the shape of a data structure.
  #
  # ds: Ruby object of type Array/Set/Hash
  #
  # Returns: string

  typename = ds.class

  # handle Array and Set
  if [Array, Set].include?(typename)
    t = []
    ds.each { |x| t.append(structshape(x)) }
    rep = "#{typename} of #{arrayrep(t)}"
    return rep
  # handle Hash
  elsif typename == Hash
    keys = Set[]
    vals = Set[]
    ds.each do |k, v|
      keys.add(structshape(k))
      vals.add(structshape(v))
      rep = "#{typename} of #{ds.size} #{setrep(keys)}->#{setrep(vals)}"
    end
    return rep
  # handle other types
  else
    return typename
  end
end

def arrayrep(t)
  # Returns a string representation of an array of type strings.
  #
  # t: array of strings
  #
  # Returns: string

  current = t[0]
  count = 0
  res = []
  t.each do |x|
    if x == current
      count += 1
    else
      append(res, current, count)
      current = x
      count = 1
    end
  end
  append(res, current, count)
  return setrep(res)
end

def setrep(s)
  # Returns a string representation of a set of type strings.
  #
  # s: set of strings
  #
  # Returns: string

  rep = s.to_a.join(', ')
  return s.size == 1 ? rep : "(#{rep})"
end

def append(res, typestr, count)
  # Adds a new element to an array of type strings.
  #
  # Modifies res.
  #
  # res: array of type strings
  # typestr: the new type string
  # count: how many of the new type there are

  rep = count == 1 ? typestr : "#{count} #{typestr}"
  res.append(rep)
end

if __FILE__ == $0
  t = [1, 2, 3]
  puts structshape(t)

  t2 = [[1, 2], [3, 4], [5, 6]]
  puts structshape(t2)

  t3 = [1, 2, 3, 4.0, '5', '6', [7], [8], 9]
  puts structshape(t3)

  s = Set['a', 'b', 'c']
  puts structshape(s)

  a2 = t.zip(s)
  puts structshape(a2)

  h = a2.to_h
  puts structshape(h)
end

