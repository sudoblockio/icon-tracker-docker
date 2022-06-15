
SELECT s.i AS missing_numbers
		FROM generate_series(1::int,50000000::int) s(i)
		WHERE NOT EXISTS (SELECT 1 FROM block_indices WHERE number = s.i);

SELECT s.i AS missing_numbers
		FROM generate_series(1::int,50000000::int) s(i)
		WHERE NOT EXISTS (SELECT 1 FROM block_indices WHERE number = s.i);

SELECT count(s.i) AS missing_numbers
		FROM generate_series(1::int,51192935::int) s(i)
		WHERE NOT EXISTS (SELECT 1 FROM block_indices WHERE number = s.i);

SELECT count(s.i) AS missing_numbers
		FROM generate_series(1::int,51192935::int) s(i)
		WHERE NOT EXISTS (SELECT 1 FROM blocks WHERE number = s.i);
