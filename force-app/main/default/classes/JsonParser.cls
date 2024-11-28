public class JsonParser{
        public String id{get;set;}
        public String scope{get;set;}
        public String query{get;set;}
        public String sobjectType{get;set;}
        public list<orderBy> orderBy{get;set;}
        public whereCondition whereCondition{get;set;}
        public list<columns> columns{get;set;}
    public class whereCondition{
        public String field{get;set;}
        public list<String> values{get;set;}
        public String operator{get;set;}
    }
    public class orderBy{
        public String sortDirection{get;set;}
        public String nullsPosition{get;set;}
        public String fieldNameOrPath{get;set;}
    }
    public class columns{
        public Boolean sortable{get;set;}
        public String label{get;set;}
        public String selectListItem{get;set;}
        public Boolean hidden{get;set;}
        public String sortDirection{get;set;}
        public String fieldNameOrPath{get;set;}
        public Integer sortIndex{get;set;}
        public String descendingLabel{get;set;}
        public String type{get;set;}
        public String ascendingLabel{get;set;}
    }
}