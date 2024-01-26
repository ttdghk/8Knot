/* This is the SQL query that populates the explorer_pr_assignments materialized view*/

SELECT
    pr.pull_request_id,
    pr.repo_id AS ID,
    pr.pr_created_at AS created,
    pr.pr_closed_at AS closed,
    pre.created_at AS assign_date,
    pre.ACTION AS assignment_action,
    pre.cntrb_id AS assignee,
    pre.node_id AS node_id 
FROM
    (
        augur_data.pull_requests pr
        LEFT JOIN augur_data.pull_request_events pre ON (
            (
                ( pr.pull_request_id = pre.pull_request_id ) 
                AND (
                    ( pre.ACTION ) :: TEXT = ANY ( ARRAY [ ( 'unassigned' :: CHARACTER VARYING ) :: TEXT, ( 'assigned' :: CHARACTER VARYING ) :: TEXT ] ) 
                ) 
            ) 
        ) 
    )