@RestResource(urlMapping='/Widgets/*')
global class WidgetController {

    @HttpGet
    global static List<contact> getWidgets() {
        List<contact> widgets = [SELECT Name from contact];
        return widgets;
    }

    @HttpPost 
    global static String createNewWidget(String Name) {
        contact c = new contact();
        c.LastName= 'ghosh';
        insert c;

        return 'Done';
   }

   
}