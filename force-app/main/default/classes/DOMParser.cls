Public class DOMParser
{

    public PageReference parse() {
    system.debug('called');
     system.debug('textToParse--->'+textToParse);
    parse(textToParse);
        return null;
    }


    public String parsedText { get; set; }

    public String textToParse { get; set; }
private String walkThrough(DOM.XMLNode node) {
  String result = '\n';
  string fetchedval='';
  if (node.getNodeType() == DOM.XMLNodeType.COMMENT) {
    return 'Comment (' +  node.getText() + ')';
  }
  if (node.getNodeType() == DOM.XMLNodeType.TEXT) {
    return 'Text (' + node.getText() + ')';
  }
  if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
    result += 'Element: ' + node.getName();
    system.debug('node.getName()--->'+node.getName());
    if(node.getName()=='ankle')
    {
    fetchedval=node.getText().trim();
    }
    if (node.getText().trim() != '') {
      result += ', text=' + node.getText().trim();
    }
    if (node.getAttributeCount() > 0) { 
      for (Integer i = 0; i< node.getAttributeCount(); i++ ) {
        result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' + node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
      }  
    }
    for (Dom.XMLNode child: node.getChildElements()) {
      result += walkThrough(child);
    }
    system.debug('result --->'+result);
     system.debug('fetchedval--->'+fetchedval);
    return result;
  }
  return '';  //should never reach here 
}
private String parse(String toParse) {
  DOM.Document doc = new DOM.Document();      
  try {
    doc.load(toParse);    
    DOM.XMLNode root = doc.getRootElement();
    parsedText=walkThrough(root);
    //String str = JSON.serialize(parsedText);
    //system.debug('parsedText--->'+str);
    return walkThrough(root);
    
  } catch (System.XMLException e) { 
   // invalid XML
   system.debug('Exception message--->'+e.getmessage() +'_'+e.getlinenumber());
    return e.getMessage();
  }
}
}