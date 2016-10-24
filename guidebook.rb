require 'elasticsearch'

class GuideBook
  
  @es
  @esIndex
  @esType

  def initialize()
    @es = Elasticsearch::Client.new hosts: "localhost:9200"
    @esIndex = "guidebook"
    @esType = "description"
  end
  
  def analyze(text)
    params = {analyzer: "kuromoji"}
    body = {text: text}
    response = @es.transport.perform_request('GET',"/#{@esIndex}/_analyze", params, body)
    return response.body
  end
  
  def find(text)
    
    tokens = ""
    analyze(text)["tokens"].each do |val|
      tokens += " " + val["token"]
    end
    
    puts "キーワード : #{tokens}\n\n"
    
    body = {query:{ match: { _all: tokens } } }
    res = @es.search(index: @esIndex, type: @esType, body: body)

    text = ""
    
    if res["hits"]["hits"].length > 0 then
      
      text = "ここの情報が役に立ちそうですよ。\n\n"
      i = 0
      res["hits"]["hits"].each do |row|
        text += "#{row["_source"]["code"]}\n[#{row["_source"]["title"]}]\n#{row["_source"]["contact"]}\n\n"
        i += 1
        if i > 2 then
          break
        end
      end
    
    else
      text = "あ〜、見つからないですね(-_-;)"
    end
  
    return text.gsub("\n","<br />")
    
  end
  
end
