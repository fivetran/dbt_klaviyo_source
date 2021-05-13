# Klaviyo (Source)

This package models Klaviyo data from [Fivetran's connector](https://fivetran.com/docs/applications/klaviyo). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/klaviyo#schemainformation).

This package enriches your Fivetran data by doing the following:
* Adds descriptions to tables and columns that are synced using Fivetran
* Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Models staging tables, which will be used in our transform package

## Models

This package contains staging models, designed to work simultaneously with our [Klaviyo modeling package](https://github.com/fivetran/dbt_klaviyo). The staging models:
* Remove any rows that are soft-deleted
* Name columns consistently across all packages:
    * Boolean fields are prefixed with `is_` or `has_`
    * Timestamps are appended with `_at`
    * ID primary keys are prefixed with the name of the table.  For example, a user table's ID column is renamed `user_id`
    * Foreign keys include the table that they refer to. For example, a project table's owner ID column is renamed `owner_user_id`

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration

By default, this package looks for your Klaviyo data in the `klaviyo` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Klaviyo data is, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    klaviyo_database: your_database_name
    klaviyo_schema: your_schema_name 
```

### Passthrough Columns

Additionally, this package includes all source columns defined in the macros folder. We highly recommend including custom fields in this package as models now only bring in the standard fields for the `EVENT` and `PERSON` tables. You can add more columns using our passthrough column variables. These variables allow the passthrough fields to be aliased (`alias`) and casted (`transform_sql`) if desired, although it is not required. Datatype casting is configured via a SQL snippet within the `transform_sql` key. You may add the desired SQL snippet while omitting the `as field_name` part of the casting statement - this will be dealt with by the alias attribute - and your custom passthrough fields will be casted accordingly.

Use the following format for declaring the respective passthrough variables:

```yml
# dbt_project.yml

...
vars:

  klaviyo__event_pass_through_columns:
    - name:           "property_field_id"
      alias:          "new_name_for_this_field_id"
      transform_sql:  "cast(new_name_for_this_field as int64)"
    - name:           "this_other_field"
      transform_sql:  "cast(this_other_field as string)"
  klaviyo__person_pass_through_columns:
    - name:           "custom_crazy_field_name"
      alias:          "normal_field_name"
```

### Changing the Build Schema

By default, this package will build the Klaviyo staging models within a schema titled (`<target_schema>` + `_stg_klaviyo`) in your target database. If this is not where you would like your Klaviyo staging data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
    klaviyo_source:
        +schema: my_new_schema_name # leave blank for just the target_schema
```

> Note that if your profile does not have permissions to create schemas in your warehouse, you can set the `+schema` to blank. The package will then write all tables to your pre-existing target schema.

## Contributions

Don't see a model or specific metric you would have liked to be included? Notice any bugs when installing 
and running the package? If so, we highly encourage and welcome contributions to this package! 
Please create issues or open PRs against `master`. Check out [this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package.

## Database Support
This package has been tested on BigQuery, Snowflake, Redshift, and Postgres.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions, feedback, or need help? Book a time during our office hours [using Calendly](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate [dbt transformations with Fivetran](https://fivetran.com/docs/transformations/dbt)
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
