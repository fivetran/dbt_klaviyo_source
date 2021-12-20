# dbt_klaviyo_source v0.5.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.
## For dbt Spark Users
- This release has a dependency on `spark-utils` [">=0.2.0", "<0.3.0"] which does not contain an official full dbt v1 compatibility release. As such, this release does not fully support dbt v1.0.0 for dbt spark users. 
 - Once the dbt v1.0.0 release of `spark-utils` is live, a `0.0.x` patch release will be applied on this package for full spark dbt v1 compatiblity.

# dbt_klaviyo_source v0.4.0
## Breaking Changes
- The `union_schemas` and `union_databases` variables have been replaced with `klaviyo_union_schemas` and `klaviyo_union_databases` respectively. This allows for multiple packages with the union ability to be used and not locked to a single variable that is used across packages.
## Under the Hood
- Added a surrogate key within `stg_klaviyo__event` to capture unique combination of `event_id` and `source_relation` columns. This will be used in downstream incremental models configurations.

# dbt_klaviyo_source v0.3.0

## Features
- Allow for multiple sources by unioning source tables across multiple Klaviyo connectors.
([#8](https://github.com/fivetran/dbt_klaviyo_source/pull/8) & [#9](https://github.com/fivetran/dbt_klaviyo_source/pull/9))
  - Refer to the [README](https://github.com/fivetran/dbt_klaviyo_source#unioning-multiple-klaviyo-connectors) for more details.

## Under the Hood
- Unioning: The unioning occurs in the tmp models using the `fivetran_utils.union_data` macro. ([#8](https://github.com/fivetran/dbt_klaviyo_source/pull/8))
- Unique tests: Because columns that were previously used for unique tests may now have duplicate fields across multiple sources, these columns are combined with the new `source_relation` column for unique tests and tested using the `dbt_utils.unique_combination_of_columns` macro. ([#8](https://github.com/fivetran/dbt_klaviyo_source/pull/8))
- Source Relation column: To distinguish which source each field comes from, we added a new `source_relation` column in each staging model and applied the `fivetran_utils.source_relation` macro. ([#8](https://github.com/fivetran/dbt_klaviyo_source/pull/8))

## Contributors
- [@pawelngei](https://github.com/pawelngei) [#8](https://github.com/fivetran/dbt_klaviyo_source/pull/8)

# dbt_klaviyo_source v0.1.0 -> v0.3.0
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
