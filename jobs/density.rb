module Density
  DENSITY_X2 = {}
  DENSITY_X3 = {}
  DENSITY_X4 = {}
  DENSITY_X5 = {}
  def words_density_2(text)
    clean_text = text.gsub(/\n/, ' ')
    splitted = clean_text.split
    arr = []
    i = 1
    while i < splitted.length
      arr << splitted[i-1] + " " + splitted[i]
      i += 1
    end
    arr.each do |element|
      if DENSITY_X2[element]
        DENSITY_X2[element] += 1
      else
        DENSITY_X2[element] = 1
      end
    end
  end
  
  def words_density_3(text)
    clean_text = text.gsub(/\n/, ' ')
    splitted = clean_text.split
    arr = []
    i = 2
    while i < splitted.length
      arr << splitted[i-2] + " " + splitted[i-1] + " " + splitted[i]
      i += 2
    end
    arr.each do |element|
      element = element.gsub(/[«».,:!;()'"?]/,'')
      if DENSITY_X3[element]
        DENSITY_X3[element] += 1
      else
        DENSITY_X3[element] = 1
      end
    end
  end
  
  def words_density_4(text)
    clean_text = text.gsub(/\n/, ' ')
    splitted = clean_text.split
    arr = []
    i = 3
    while i < splitted.length
      arr << splitted[i-3] + " " + splitted[i-2] + " " + splitted[i-1] + " " + splitted[i]
      i += 3
    end
    arr.each do |element|
      element = element.gsub(/[«».,:!;()'"?]/,'')
      if DENSITY_X4[element]
        DENSITY_X4[element] += 1
      else
        DENSITY_X4[element] = 1
      end
    end
  end
  
  def words_density_5(text)
    clean_text = text.gsub(/\n/, ' ')
    splitted = clean_text.split
    arr = []
    i = 4
    while i < splitted.length
      arr << splitted[i-4] + " " + splitted[i-3] + " " + splitted[i-2] + " " + splitted[i-1] + " " + splitted[i]
      i += 4
    end
    arr.each do |element|
      element = element.gsub(/[«».,:!;()'"?]/,'')
      if DENSITY_X5[element]
        DENSITY_X5[element] += 1
      else
        DENSITY_X5[element] = 1
      end
    end
  end
    
  def density2_array
    arr = []
    DENSITY_X2.sort {|a,b| a[1] <=> b[1]}.reverse.each do |key, value|
      arr << "#{key}: #{value}" if value >= 3
    end
    return arr
  end
  def density3_array
    arr = []
    DENSITY_X3.sort {|a,b| a[1] <=> b[1]}.reverse.each do |key, value|
      arr << "#{key}: #{value}" if value  >= 2
    end
    return arr
  end
  def density4_array
    arr = []
    DENSITY_X4.sort {|a,b| a[1] <=> b[1]}.reverse.each do |key, value|
      arr << "#{key}: #{value}" if value >= 2
    end
    return arr
  end
  def density5_array
    arr = []
    DENSITY_X5.sort {|a,b| a[1] <=> b[1]}.reverse.each do |key, value|
      arr << "#{key}: #{value}" if value >= 2
    end
    return arr
  end
end