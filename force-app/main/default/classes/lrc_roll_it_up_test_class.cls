/*
    Name: lrc_roll_it_up_test_class
    Description: single test class for the whole package.
*/
@isTest
private class lrc_roll_it_up_test_class {
        
    /*
    creates the common seed data using Opportunity and Account objects. 
    */
    static void prepareData() {
        acc1 =  lrc_data_factory.init_account('Acc1');
        acc2 =  lrc_data_factory.init_account('Acc2');
        insert new Account[] {acc1, acc2};
            
        Opportunity o1Acc1 = lrc_data_factory.init_opportunity('o1Acc1');        
        o1Acc1.Name = 'o1Acc1'; 
        o1Acc1.AccountId = acc1.Id;
        o1Acc1.Amount = 100.00;
        o1Acc1.CloseDate = System.today();
        o1Acc1.StageName = 'test';
          
        Opportunity o2Acc1 = lrc_data_factory.init_opportunity('o2Acc1');
        o2Acc1.Name = 'o2Acc1';
        o2Acc1.AccountId = acc1.Id;
        o2Acc1.Amount = 300.00;
        o2Acc1.CloseDate = System.today().addMonths(1);
        o2Acc1.StageName = 'test';
        
        
        Opportunity o3Acc1 = lrc_data_factory.init_opportunity('o3Acc1');
        o3Acc1.Name = 'o3Acc1';
        o3Acc1.AccountId = acc1.Id;
        o3Acc1.Amount = 50.00;
        o3Acc1.CloseDate = System.today().addMonths(-1);
        o3Acc1.StageName = 'test';
       
        
        Opportunity o1Acc2 = lrc_data_factory.init_opportunity('o1Acc2');
        o1Acc2.Name = 'o1Acc2';
        o1Acc2.AccountId = acc2.Id;
        o1Acc2.Amount = 200.00;
        o1Acc2.CloseDate = System.today().addMonths(2);
        o1Acc2.StageName = 'Won';
        
        
        Opportunity o2Acc2 = lrc_data_factory.init_opportunity('o2Acc2');
        o2Acc2.Name = 'o2Acc2';
        o2Acc2.AccountId = acc2.Id;
        o2Acc2.Amount = 400.00;
        o2Acc2.CloseDate = System.today().addMonths(3);
        o2Acc2.StageName = 'Lost';
       
        
        Opportunity o3Acc2 = lrc_data_factory.init_opportunity('o3Acc2');
        o3Acc2.Name = 'o3Acc2';
        o3Acc2.AccountId = acc2.Id;
        o3Acc2.Amount = 300.00;
        o3Acc2.CloseDate = System.today().addMonths(4);
        o3Acc2.StageName = 'Won';
       
        detailRecords = new Opportunity[] {o1Acc1, o2Acc1, o3Acc1, o1Acc2, o2Acc2, o3Acc2};
            if(ANNUALIZED_RECCURING_REVENUE!=null)
            for(Opportunity detailRecord : detailRecords)
            detailRecord.put(ANNUALIZED_RECCURING_REVENUE, 1000);
        detailRecordsAcc1 = new Opportunity[] {o1Acc1, o2Acc1, o3Acc1};
            insert detailRecords;          
    }       
    
    
    
    
    /*
    Testing lrc_roll_it_up_compose_controller_apex
    */
    static testMethod void testlrc_roll_it_up_compose_controller_apex() {
        
        lrc_roll_it_up_compose_controller_apex.save_roll_up_data('Opportunity', 'Amount',  'Account', 
                                                                 'AnnualRevenue', 'Sum', 
                                                                 'Amount > 200', 'AccountId');
        
        boolean b = lrc_roll_it_up_compose_controller_apex.query_validator('SELECT ID FROM ACCOUNT');
        
        List < string > s = lrc_roll_it_up_compose_controller_apex.fetchLookUpValues('','lrc_target_object');
        List < string > s1 = lrc_roll_it_up_compose_controller_apex.fetchLookUpValues('','Account;lrc_source_object');
        List < string > s2 = lrc_roll_it_up_compose_controller_apex.fetchLookUpValues('','Account;Sum;lrc_target_field');
        List < string > s3 = lrc_roll_it_up_compose_controller_apex.fetchLookUpValues('','Account;lrc_source_field' + ';' + 'field_type');
        List < string > s4 = lrc_roll_it_up_compose_controller_apex.fetchLookUpValues('','Account;lrc_source_field;INT');
        List < string > s5 = lrc_roll_it_up_compose_controller_apex.fetchLookUpValues('','lrc_target_object');
        List < string > s6 = lrc_roll_it_up_compose_controller_apex.fetchLookUpValues('','lrc_target_object');
        
    }
    
    /*
    Testing download_csv_apex
    */
    static testMethod void testdownload_csv_apex() {
    	list<lrc_roll_up_outline2__c> s = lrc_download_csv_apex.fetch_data();
    }
    
    /*
    Testing lrc_roll_it_up_dashboard_class
    */
    static testMethod void testlrc_roll_it_up_dashboard_class() {
        lrc_roll_it_up_dashboard_class instance = new lrc_roll_it_up_dashboard_class();
        lrc_roll_it_up_dashboard_class.lightningTableWraper data = lrc_roll_it_up_dashboard_class.getsObjectRecords('lrc_roll_up_outline2__c',
                                                                                             'name,lrc_active__c,lrc_roll_up_operation_type__c,lrc_source_object__c,lrc_source_field__c,lrc_target_object__c,lrc_target_field__c');
    	lrc_roll_up_outline2__c obj = new lrc_roll_up_outline2__c();
        obj.name = 'Account_AnnualRevenuetest';
        obj.lrc_source_object__c = 'Opportunity';
        obj.lrc_source_field__c = 'Amount';
        obj.lrc_target_object__c = 'Account';
        obj.lrc_target_field__c = 'AnnualRevenue';
        obj.lrc_roll_up_operation_type__c = 'Sum';
        obj.lrc_active__c = true;
        obj.filter_criteria__c = 'Amount > 200';
        obj.lrc_target_object_relation__c = 'AccountId';
        insert obj;
            
        lrc_roll_it_up_dashboard_class.perform_row_event('Account_AnnualRevenuetest','activate');
        lrc_roll_it_up_dashboard_class.perform_row_event('Account_AnnualRevenuetest','de_activate');
        lrc_roll_it_up_dashboard_class.perform_row_event('Account_AnnualRevenuetest','delete');
    }
    
    /*
    Testing lrc_Handle_Exception
    */
    static testMethod void testlrc_Handle_Exception() {
        try{
            account a = new account();
            insert a;
        }catch(Exception e){
            lrc_Handle_Exception.LogException(e, '');
        }
    }
    
    /*
    Testing lrc_roll_it_up_class
    */
    static testMethod void testlrc_roll_it_up_class() {
        lrc_roll_up_outline2__c obj = new lrc_roll_up_outline2__c();
        obj.name = 'Account_AnnualRevenuetest';
        obj.lrc_source_object__c = 'Opportunity';
        obj.lrc_source_field__c = 'Amount';
        obj.lrc_target_object__c = 'Account';
        obj.lrc_target_field__c = 'AnnualRevenue';
        obj.lrc_roll_up_operation_type__c = 'Sum';
        obj.lrc_active__c = true;
        obj.filter_criteria__c = 'Amount > 200';
        obj.lrc_target_object_relation__c = 'AccountId';
        insert obj;
        
        lrc_roll_up_outline2__c obj2 = new lrc_roll_up_outline2__c();
        obj2.name = 'Account_NumberOfEmployeestest';
        obj2.lrc_source_object__c = 'Opportunity';
        obj2.lrc_source_field__c = 'Id';
        obj2.lrc_target_object__c = 'Account';
        obj2.lrc_target_field__c = 'NumberOfEmployees';
        obj2.lrc_roll_up_operation_type__c = 'Count';
        obj2.lrc_active__c = true;
        obj2.filter_criteria__c = '';
        obj2.lrc_target_object_relation__c = 'AccountId';
        insert obj2;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_class.rollUp(new map<id, sobject>([SELECT Id, Amount, AccountId FROM Opportunity]), null, false);
        
        
    }
    
    /*
    Tests sum and max operations on currency and date fields
    */
    static testMethod void testSumAndMaxOperations() {
        
        // Required custom field/s present?
        if(ACCOUNT_SLA_EXPIRATION_DATE==null)
            return;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType,  
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId);
        
        //Select o.TotalOpportunityQuantity, o.ExpectedRevenue, o.CloseDate, o.Account.rollups__SLAExpirationDate__c, 
        // o.Account.rollups__NumberofLocations__c, o.AccountId From Opportunity o
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Sum'
            )); 
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                ACCOUNT_SLA_EXPIRATION_DATE.getDescribe(),
                Schema.SObjectType.Opportunity.fields.CloseDate,
                'Max'
            ));                                       
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);  
        // 2 masters should be back  
        System.assertEquals(2, masters.size());
        
        System.debug(masters + ' '  + acc1 + ' '  + acc2);
        Account reloadedAcc1, reloadedAcc2;         
        for (Sobject so : masters) { 
            if (so.Id == acc1.id) reloadedAcc1 = (Account)so;
            if (so.Id == acc2.id) reloadedAcc2 = (Account)so;
        }
        System.assertEquals(450.00, reloadedAcc1.AnnualRevenue);
        System.assertEquals(900.00, reloadedAcc2.AnnualRevenue);
        
        System.assertEquals(System.today().addMonths(1), reloadedAcc1.get(ACCOUNT_SLA_EXPIRATION_DATE));
        System.assertEquals(System.today().addMonths(4), reloadedAcc2.get(ACCOUNT_SLA_EXPIRATION_DATE));
        
    }
    
    
    /*
    Tests sum and max operations on currency and date fields
    */
    static testMethod void testAvgAndCountOperations() {
        
        // Required custom field/s present?
        if(ACCOUNT_NUMBER_OF_EMPLOYEES==null)
            return;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType, 
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId);
        
        //Select o.TotalOpportunityQuantity, o.ExpectedRevenue, o.CloseDate, o.Account.rollups__SLAExpirationDate__c, 
        // o.Account.rollups__NumberofLocations__c, o.AccountId From Opportunity o
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Avg'
            )); 
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                ACCOUNT_NUMBER_OF_EMPLOYEES.getDescribe(),
                Schema.SObjectType.Opportunity.fields.CloseDate,
                'Count'
            ));                                       
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);                 
        // 2 masters should be back  
        System.assertEquals(2, masters.size());
        
        System.debug(masters + ' '  + acc1 + ' '  + acc2);
        Account reloadedAcc1, reloadedAcc2;         
        for (Sobject so : masters) { 
            if (so.Id == acc1.id) reloadedAcc1 = (Account)so;
            if (so.Id == acc2.id) reloadedAcc2 = (Account)so;
        }
        // avg would be (50 + 100 + 300) / 3 = 150
        System.assertEquals(150.00, reloadedAcc1.AnnualRevenue);
        System.assertEquals(300.00, reloadedAcc2.AnnualRevenue);
        
        System.assertEquals(3, reloadedAcc1.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
        System.assertEquals(3, reloadedAcc2.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
    }
    
    
    /*
    Tests sum and max operations on currency and date fields
    */
    static testMethod void testAvgAndCountOperationsSameAggregateField() {
        
        // Required custom field/s present?
        if(ACCOUNT_NUMBER_OF_EMPLOYEES==null)
            return;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType, 
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId);
        
        //Select o.TotalOpportunityQuantity, o.ExpectedRevenue, o.CloseDate, o.Account.rollups__SLAExpirationDate__c, 
        // o.Account.rollups__NumberofLocations__c, o.AccountId From Opportunity o
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Avg'
            )); 
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                ACCOUNT_NUMBER_OF_EMPLOYEES.getDescribe(),
                Schema.SObjectType.Opportunity.fields.Amount,
                'Count'
            ));                                       
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);                 
        // 2 masters should be back  
        System.assertEquals(2, masters.size());
        
        System.debug(masters + ' '  + acc1 + ' '  + acc2);
        Account reloadedAcc1, reloadedAcc2;         
        for (Sobject so : masters) { 
            if (so.Id == acc1.id) reloadedAcc1 = (Account)so;
            if (so.Id == acc2.id) reloadedAcc2 = (Account)so;
        }
        // avg would be (50 + 100 + 300) / 3 = 150
        System.assertEquals(150.00, reloadedAcc1.AnnualRevenue);
        System.assertEquals(300.00, reloadedAcc2.AnnualRevenue);
        
        System.assertEquals(3, reloadedAcc1.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
        System.assertEquals(3, reloadedAcc2.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
    }
    
    /*
    Tests count distinct
    */
    static testMethod void testCountDistinctOperations() {
        
        // Required custom field/s present?
        if(ACCOUNT_NUMBER_OF_EMPLOYEES==null)
            return;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType, 
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId);         
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.StageName,
                'Count_Distinct'
            )); 
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);                 
        // 2 masters should be back  
        System.assertEquals(2, masters.size());
        
        Account reloadedAcc1, reloadedAcc2;         
        for (Sobject so : masters) { 
            if (so.Id == acc1.id) reloadedAcc1 = (Account)so;
            if (so.Id == acc2.id) reloadedAcc2 = (Account)so;
        }
        
        System.assertEquals(1, reloadedAcc1.AnnualRevenue); // Only one set of distinct StageName's on Account 1
        System.assertEquals(2, reloadedAcc2.AnnualRevenue); // Two sets of distinct StageName's on Account 2
    }
    
    
    /*
    Tests sum and max operations on currency and date fields
    Here we will pass our custom criteria to filter certain records in detail, just like master detail rollup fields
    */
    static testMethod void testAvgAndCountOperationsWithFilter() {
        
        // Required custom field/s present?
        if(ACCOUNT_NUMBER_OF_EMPLOYEES==null)
            return;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType, 
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId,
                                                                                          'Amount > 200' // filter out any opps with amount less than 200
                                                                                         );
        
        //Select o.TotalOpportunityQuantity, o.ExpectedRevenue, o.CloseDate, o.Account.rollups__SLAExpirationDate__c, 
        // o.Account.rollups__NumberofLocations__c, o.AccountId From Opportunity o
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Avg'
            )); 
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                ACCOUNT_NUMBER_OF_EMPLOYEES.getDescribe(),
                Schema.SObjectType.Opportunity.fields.CloseDate,
                'Count'
            ));                                       
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);                 
        // 2 masters should be back  
        System.assertEquals(2, masters.size());
        
        System.debug(masters + ' '  + acc1 + ' '  + acc2);
        Account reloadedAcc1, reloadedAcc2;         
        for (Sobject so : masters) { 
            if (so.Id == acc1.id) reloadedAcc1 = (Account)so;
            if (so.Id == acc2.id) reloadedAcc2 = (Account)so;
        }
        // avg would be 300 as other two records of amount 50 and 100 should be skipped
        System.assertEquals(300, reloadedAcc1.AnnualRevenue);
        System.assertEquals(350.00, reloadedAcc2.AnnualRevenue);
        
        System.assertEquals(1, reloadedAcc1.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
        System.assertEquals(2, reloadedAcc2.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
    }
    
    /**
    * Test fix where rollup field on master records where not
    * cleared or zerod when all children deleted
    **/
    static testMethod void testDeletingChildRecords()
    {
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(
            Account.SobjectType, 
            Opportunity.SobjectType, 
            Schema.SObjectType.Opportunity.fields.AccountId,
            'Amount > 200'); // filter out any opps with amount less than 200
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Avg')); 
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);
        Map<Id, Sobject> mastersById = new Map<Id, Sobject>(masters);
        System.assertEquals(2, masters.size());         
        System.assertEquals(300, ((Account)mastersById.get(acc1.id)).AnnualRevenue);
        System.assertEquals(350.00, ((Account)mastersById.get(acc2.id)).AnnualRevenue);
        
        // Delete all children
        delete [select Id from Opportunity];
        
        // Recacluate rollups again
        masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);  
        mastersById = new Map<Id, Sobject>(masters);               
        System.assertEquals(0, ((Account)mastersById.get(acc1.id)).AnnualRevenue);
        System.assertEquals(0, ((Account)mastersById.get(acc2.id)).AnnualRevenue);
    }
    
    /**
    * Test enhancement to ensure the SOQL Aggregate only applies to child records 
    *  related to masters referenced in incoming child records
    **/
    static testMethod void testConstrainedAggregateQuery()
    {
        // Required custom field/s present?
        if(ACCOUNT_SLA_EXPIRATION_DATE==null)
            return;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType,  
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId);         
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Sum'
            )); 
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                ACCOUNT_SLA_EXPIRATION_DATE.getDescribe(),
                Schema.SObjectType.Opportunity.fields.CloseDate,
                'Max'
            ));                                       
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecordsAcc1);      
        
        // Verify the results of the query
        System.assertEquals(1, masters.size());
        System.assertEquals(450.00, masters.get(0).get('AnnualRevenue'));
    }
    
    /*
    Fixed crash when using field names longer then 25 chars.
    System.QueryException: alias is too long, maximum of 25 characters: Annualized_Recurring_Revenue__c
    To test this please create a custom Number field by api name "Annualized_Recurring_Revenue__c" in Opportunity
    */
    static testMethod void testLongDetailFields() {
        
        // Required custom field/s present?
        if(ANNUALIZED_RECCURING_REVENUE==null || ACCOUNT_NUMBER_OF_EMPLOYEES==null)
            return;
        
        // create seed data 
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType, 
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId,
                                                                                          'Amount > 200' // filter out any opps with amount less than 200
                                                                                         );
        
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                ACCOUNT_NUMBER_OF_EMPLOYEES.getDescribe(),
                ANNUALIZED_RECCURING_REVENUE.getDescribe(),
                'Count'
            )); 
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);                 
        // 2 masters should be back  
        System.assertEquals(2, masters.size());
        
        Account reloadedAcc1, reloadedAcc2;         
        for (Sobject so : masters) { 
            if (so.Id == acc1.id) reloadedAcc1 = (Account)so;
            if (so.Id == acc2.id) reloadedAcc2 = (Account)so;
        }
        
        System.assertEquals(1, reloadedAcc1.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
        System.assertEquals(2, reloadedAcc2.get(ACCOUNT_NUMBER_OF_EMPLOYEES));
    }
    
    /*
    Test Multi-Currency installations
    */
    static testMethod void testCurrencyConversionFields() {
        
        // is org multi-currency?
        // org has at least one non-corporate, not equivalent, currency installed.
        if(IsMultiCurrencyOrg() == false || hasMultiCurrency() == false)
            return;
        
        // create seed data 
        prepareData();
        
        // change the currency of one of the master records to force currency conversion
        sObject ct = Database.query('select IsoCode, ConversionRate from CurrencyType where IsActive = true AND IsCorporate = false AND ConversionRate != 1 limit 1');
        acc1.put(CURRENCYISOCODENAME, ct.get('IsoCode'));
        update acc1;
        
        //change currency of one account
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType, 
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId
                                                                                         );
        
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Sum'
            ));
        
        Sobject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);
        
        Decimal acct1Val = 0.0;
        Decimal acct2Val = 0.0;
        for(Sobject so : detailRecords){
            if(so.get('AccountId') == acc1.Id) acct1Val += (Decimal)so.get('Amount');
            if(so.get('AccountId') == acc2.Id) acct2Val += (Decimal)so.get('Amount');
        }
        System.Debug('Conversion Rate:'+ct.get('ConversionRate'));
        System.Debug('Acct1 Val:'+acct1Val);
        
        acct1Val = acct1Val * (Decimal)ct.get('ConversionRate');
        
        System.Debug('Acct1 Conv Val:'+acct1Val);
        
        Account reloadedAcc1, reloadedAcc2;
        for (Sobject so : masters) {
            if (so.Id == acc1.id) reloadedAcc1 = (Account)so;
            if (so.Id == acc2.id) reloadedAcc2 = (Account)so;
        }
        
        //Test amount values for conversion accuracy
        System.assertEquals(acct1Val, (Decimal)reloadedAcc1.get('AnnualRevenue'));
        System.assertEquals(acct2Val, (Decimal)reloadedAcc2.get('AnnualRevenue'));
    }
    
    static testMethod void testRollupSummaryFieldValidation() {
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(Account.SobjectType, 
                                                                                          Opportunity.SobjectType, 
                                                                                          Schema.SObjectType.Opportunity.fields.AccountId);
        
        // Valid
        ctx.add(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Id,
                'Count'
            ));                 
        
        try {
            // Not Valid
            ctx.add(
                new lrc_roll_it_up_helper_class.RollupSummaryField(
                    Schema.SObjectType.Account.fields.AnnualRevenue,
                    Schema.SObjectType.Opportunity.fields.Id,
                    'Sum'
                ));                 
            System.assert(false, 'Expecting an exception');
        }
        catch (Exception e) {
            System.assertEquals('Only Date/DateTime/Time/Numeric fields are allowed for Sum, Max, Min and Avg', e.getMessage());
        }
    }   
    
    static testMethod void testRollupContextsValidRollupFieldCombosOnly() {
        
        // Cannot mix (Sum, Max, Min, Avg, Count, Count_Distinct) with (Concatenate, Concatenate_Distinct, First, Last)
        try {
            lrc_roll_it_up_helper_class.Context ctx = 
                new lrc_roll_it_up_helper_class.Context(
                    Account.SobjectType, Opportunity.SobjectType, 
                    Schema.SObjectType.Opportunity.fields.AccountId);
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                'Concatenate'));                 
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Sum'));                 
            System.assert(false, 'Expecting an exception');            
        } catch (Exception e) {
            System.assertEquals('Cannot mix Sum, Max, Min, Avg, Count, Count_Distinct operations with Concatenate, Concatenate_Distinct, First, Last operations', e.getMessage());
        }
        try {
            lrc_roll_it_up_helper_class.Context ctx = 
                new lrc_roll_it_up_helper_class.Context(
                    Account.SobjectType, Opportunity.SobjectType, 
                    Schema.SObjectType.Opportunity.fields.AccountId);
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Sum'));                 
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                'Concatenate'));                 
            System.assert(false, 'Expecting an exception');            
        } catch (Exception e) {
            System.assertEquals('Cannot mix Sum, Max, Min, Avg, Count, Count_Distinct operations with Concatenate, Concatenate_Distinct, First, Last operations', e.getMessage());
        }
    } 
    
    static testMethod void testRollupSummaryFieldValidationConcatenate() {
        // Master must be text type
        try {
            lrc_roll_it_up_helper_class.Context ctx = 
                new lrc_roll_it_up_helper_class.Context(
                    Account.SobjectType, Opportunity.SobjectType, 
                    Schema.SObjectType.Opportunity.fields.AccountId);
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Id,
                'Concatenate'));                 
            System.assert(false, 'Expecting an exception');            
        } catch (Exception e) {
            System.assertEquals('Only Text/Text Area fields are allowed for Concatenate and Concatenate Distinct', e.getMessage());
        }
    } 
    
    static testMethod void testRollupSummaryFieldValidationFirstAndLast() {
        // Master and detail field type must match
        try {
            lrc_roll_it_up_helper_class.Context ctx = 
                new lrc_roll_it_up_helper_class.Context(
                    Account.SobjectType, Opportunity.SobjectType, 
                    Schema.SObjectType.Opportunity.fields.AccountId);
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Id,
                'Last'));                 
            System.assert(false, 'Expecting an exception');            
        } catch (Exception e) {
            System.assertEquals('Master and detail fields must be the same field type (or text based) for First or Last operations', e.getMessage());
        }
        try {
            lrc_roll_it_up_helper_class.Context ctx = 
                new lrc_roll_it_up_helper_class.Context(
                    Account.SobjectType, Opportunity.SobjectType, 
                    Schema.SObjectType.Opportunity.fields.AccountId);
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Id,
                'First'));                 
            System.assert(false, 'Expecting an exception');            
        } catch (Exception e) {
            System.assertEquals('Master and detail fields must be the same field type (or text based) for First or Last operations', e.getMessage());
        }
        // Master and detail field type match
        try {
            lrc_roll_it_up_helper_class.Context ctx = 
                new lrc_roll_it_up_helper_class.Context(
                    Account.SobjectType, Opportunity.SobjectType, 
                    Schema.SObjectType.Opportunity.fields.AccountId);
            ctx.add(new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AnnualRevenue,
                Schema.SObjectType.Opportunity.fields.Amount,
                'First'));                 
        } catch (Exception e) {
            System.assert(false, 'Not expecting an exception ' + e.getMessage());
        }
    } 
    
    static testMethod void testRollupConcatenateTruncate() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.AccountNumber,
                Schema.SObjectType.Opportunity.fields.StageName,
                null, 'Concatenate', '01234567890123456789,'),
            'test01234567890123456789,test01234567...',
            'Lost01234567890123456789,Won012345678...');
    }    
    
    static testMethod void testRollupConcatenate() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                null, 'Concatenate', ','),
            'test,test,test',
            'Lost,Won,Won');
    } 
    
    
    static testMethod void testRollupConcatenateBR() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                null, 'Concatenate', 'BR()'),
            'test\ntest\ntest',
            'Lost\nWon\nWon');
    } 
    
    static testMethod void testRollupConcatenateOrderBy() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Concatenate', ','),
            'test,test,test',
            'Won,Won,Lost');
    } 
    
    static testMethod void testRollupConcatenateNoDelimiter() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                null, 'Concatenate', null),
            'testtesttest',
            'LostWonWon');
    } 
    
    static testMethod void testRollupConcatenateDistinct() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                null, 'Concatenate_Distinct', ','),
            'test',
            'Lost,Won');
    } 
    
    static testMethod void testRollupConcatenateDistinctWithOrderBy() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Concatenate_Distinct', ','),
            'test',
            'Won,Lost');
    } 
    
    static testMethod void testRollupFirst() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                Schema.SObjectType.Opportunity.fields.Amount,
                'First', null),
            'test',
            'Won');
    }
    
    static testMethod void testRollupLast() {
        testRollup(
            new lrc_roll_it_up_helper_class.RollupSummaryField(
                Schema.SObjectType.Account.fields.Description,
                Schema.SObjectType.Opportunity.fields.StageName,
                Schema.SObjectType.Opportunity.fields.Amount,
                'Last', null),
            'test',
            'Lost');
    } 
    
    static private void testRollup(lrc_roll_it_up_helper_class.RollupSummaryField rollupField, String expected1, String expected2) {
        
        prepareData();
        
        lrc_roll_it_up_helper_class.Context ctx = new lrc_roll_it_up_helper_class.Context(
            Account.SobjectType, 
            Opportunity.SobjectType, 
            Schema.SObjectType.Opportunity.fields.AccountId);
        
        ctx.add(rollupField);
        
        SObject[] masters = lrc_roll_it_up_helper_class.rollUp(ctx, detailRecords);
        
        Map<Id, SObject> mastersById = new Map<Id, SObject>(masters);
        Account reloadedAcc1 = (Account)mastersById.get(acc1.Id);
        Account reloadedAcc2 = (Account)mastersById.get(acc2.Id);
        System.assertEquals(2, masters.size());
        System.assertEquals(expected1, reloadedAcc1.get(rollupField.master.getName()));
        System.assertEquals(expected2, reloadedAcc2.get(rollupField.master.getName()));
    } 

    // common master records for the test case
    static Account acc1, acc2;
    // common bunch of detail records for the test case
    static Opportunity[] detailRecords;
    static Opportunity[] detailRecordsAcc1;
    // dynamic reference to this field to avoid it being included in the package
    static Schema.SObjectField ACCOUNT_SLA_EXPIRATION_DATE;
    static Schema.SObjectField ACCOUNT_NUMBER_OF_EMPLOYEES;
    static Schema.SObjectField ANNUALIZED_RECCURING_REVENUE;
    static
    {
        // dynamically resolve these fields, if they are not present when the test runs, the test will return as passed to avoid failures in subscriber org when packaged
        Map<String, Schema.SObjectField> accountFields = Schema.SObjectType.Account.fields.getMap();
        ACCOUNT_SLA_EXPIRATION_DATE = accountFields.get('SLAExpirationDate__c');
        ACCOUNT_NUMBER_OF_EMPLOYEES = accountFields.get('NumberOfEmployees');
        Map<String, Schema.SObjectField> opportunityFields = Schema.SObjectType.Opportunity.fields.getMap();
        ANNUALIZED_RECCURING_REVENUE = opportunityFields.get('Annualized_Recurring_Revenue__c');            
    }
    
    /*added to support multi-currency detection*/
    
    private static String CURRENCYISOCODENAME = 'CurrencyIsoCode';
    //http://advancedapex.com/2013/07/07/optional-features/
    private static Boolean m_IsMultiCurrency = null;
    public static Boolean IsMultiCurrencyOrg() {
        if(m_IsMultiCurrency!=null) return m_IsMultiCurrency;
        m_IsMultiCurrency = UserInfo.isMultiCurrencyOrganization();
        return m_IsMultiCurrency;
    }
    
    private static Boolean m_HasMultiCurrency = null;
    public static Boolean hasMultiCurrency() {
        if(m_HasMultiCurrency!=null) return m_HasMultiCurrency;
        m_HasMultiCurrency = (Database.countQuery('select count() from CurrencyType WHERE IsActive = true AND IsCorporate = false AND ConversionRate != 1') > 0);
        return m_HasMultiCurrency;
    }   
}