UPP - Simple Editor for Unity Player Prefs Files
================================================

This gem enable to view or edit Unity Player Prefs (.upp) files via CLI.

> **WARNING:** This gem has used source from <http://wiki.unity3d.com/index.php/UPPEditor>.
>
> It's just a quick and dirty implementation. It has some error checks but it's not "safe" yet.
> **USE AT YOUR OWN RISK**

Installation
------------
```ruby
gem 'upp', :github => 'safefiesta/upp'
```

Usage
-----
    $ upp [<file_name>]

Command list
------------
    help
    exit
    
    open <file_name>
    save [<file_name>]
    
    list [<key_name>]
    set <key_name>, <value>
    delete <key_name>, <value>

Example
-------
    $ upp test.upp
    > list
    [{:name=>"name", :value=>"John"},
     {:name=>"hp", :value=>80},
     {:name=>"power", :value=>0.7999999523162842}]
    > list "po"
    [{:name=>"power", :value=>0.7999999523162842}]
    > set "name", "Alex"
    > set "hp", 100
    > set "power", 1.15
    > save
    > exit
