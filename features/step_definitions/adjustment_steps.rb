Given /^a typical set of adjustments, buckets, and users$/ do
  Given "the following users:", table(%{
    | id  | permalink | created_at              | updated_at              |
    | 101 | bob       | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
    | 102 | harry     | 2009-09-10 13:57:01 UTC | 2009-09-10 13:57:01 UTC |
    })
  And "the following buckets:", table(%{
    | id   | permalink | created_at              | updated_at              |
    | 101  | plants    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    | 102  | animals   | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    })
  And "the following adjustments:", table(%{
    | id   | user_id | bucket_id | value | created_at              | updated_at              |
    | 101  | 101     | 101       | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
    | 102  | 101     | 102       | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
    | 103  | 102     | 101       | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
    | 104  | 102     | 102       | 4     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
    | 105  | 102     | 102       | -1    | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
    })
end
