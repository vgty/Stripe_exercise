require_relative 'density'

class Scan
  def initialize(book)
    @book = book
  end
  
  include Density

  ALL_WORDS = {}
  
  def scanner    
    case @book[:filename]
    when /.docx/
      scan_docx
    when /.txt/
      scan_txt
    when /.pdf/
      scan_pdf
    else
      puts "Nous ne pouvons parcourir ce type de fichier pour le moment. Essayez plutôt avec un fichier .docx, .txt, .pdf"
    end
  end
  
  def scan_docx
    reader = Docx::Document.open(@book[:tempfile])
    reader.paragraphs.each do |page|
      calculate_density(page.text)
      page.text.each_line do |line|
        stock_words(line)
      end
    end
  end
  
  def scan_txt
    reader = File.open(@book[:tempfile], "r")
    reader.each_line do |line|
      calculate_density(line)
      stock_words(line)
    end
  end
  
  def scan_pdf
    reader = PDF::Reader.new(@book[:tempfile])
    reader.pages.each do |page|
      calculate_density(page.text)
      page.text.each_line do |line|
        stock_words(line)
      end
    end
    
  end
  
private

  def calculate_density(text)
    words_density_2(text)
    words_density_3(text)
    words_density_4(text)
    words_density_5(text)
  end
  
  def stock_words(line)
    clean_line = line.gsub(/\n/, ' ').gsub(/-\s|n’|l’|d’|qu’/, '')
    words = clean_line.split
    words.each do |word|
      word = word.gsub(/[«».,:!;()'"?]/,'')
      if ALL_WORDS[word]
        ALL_WORDS[word] += 1
      else
        ALL_WORDS[word] = 1
      end
    end
  end
  
  def order_hash
    ALL_WORDS.sort {|a,b| a[1] <=> b[1]}.each do |key,value|
      puts "#{key} => #{value}"
    end
  end  
    
end

  
