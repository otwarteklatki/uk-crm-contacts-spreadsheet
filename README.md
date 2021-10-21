# UK CRM contacts spreadsheet

## Work in progress

A script to be run at regular intervals to query SendGrid for mailing list contacts and load the results into a Google spreadsheet.

More context: https://trello.com/c/rN2JxBpZ/127-new-tool-spreadsheet-for-uk

## Setup

Install Ruby. Version: see `.ruby-version`

```bash
bundle install # install gems
```

Create, or be given, a SendGrid API key. Restrict any new API keys' permissions only to what is necessary, to limit the damage if leaked or misused.

```bash
cp .env.example .env
```

Also, do this: https://github.com/sendgrid/sendgrid-ruby#setup-environment-variables (create a sendgrid.env file like sendgrid.env.example)

The documentation of SendGrid's libraries (including for Ruby) seems very out of date (see for example https://github.com/sendgrid/sendgrid-ruby/issues/391), so I will heavily document the code as I write it / write it in a self-documenting way. I checked the python library and its documentation seems similarly out of date with the current SendGrid API.

## Run the script

Note: running the script runs the script in real life. There is no 'staging' or 'development' SendGrid database; if you kill it in development you kill it in production.

<details>
  <summary>OK, I understand the risks</summary>

    
    ```
    ruby lib/uk_crm_contacts_spreadsheet.rb
    ```

</details>


    
