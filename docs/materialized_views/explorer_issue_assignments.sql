/* This is the SQL query that populates the explorer_issue_assignments materialized view*/

SELECT
    i.issue_id,
    i.repo_id AS ID,
    i.created_at AS created,
    i.closed_at AS closed,
    ie.created_at AS assign_date,
    ie.ACTION AS assignment_action,
    ie.cntrb_id AS assignee, 
    ie.node_id as node_id  
FROM
    (
        augur_data.issues i
        LEFT JOIN augur_data.issue_events ie ON (
            (
                ( i.issue_id = ie.issue_id ) 
                AND (
                    ( ie.ACTION ) :: TEXT = ANY ( ARRAY [ ( 'unassigned' :: CHARACTER VARYING ) :: TEXT, ( 'assigned' :: CHARACTER VARYING ) :: TEXT ] ) 
                ) 
            ) 
        ) 
    )
