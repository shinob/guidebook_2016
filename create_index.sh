curl -XPUT http://localhost:9200/guidebook -d '{ "index": { "analysis": { "analyzer": "kuromoji_analyzer" } } } } }'
