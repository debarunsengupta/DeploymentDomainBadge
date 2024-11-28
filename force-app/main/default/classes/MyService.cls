@RestResource(urlMapping='/myservice')
global class MyService {
    @Httppost
    global static string doGet() {
        //String name = RestContext.request.params.get('name');
        //return 'Hello '+name;
        return 'test';
    }
}