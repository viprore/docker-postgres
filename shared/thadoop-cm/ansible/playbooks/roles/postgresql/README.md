### create db, account

```
# su - postgres
# psql
# create database airflow;
# create user airflow with encrypted password 'airflow';
# GRANT all privileges on DATABASE airflow to airflow;
# \c airflow;
# grant all privileges on all tables in schema public to airflow;
# create database airflow_celery;
# create user airflow_celery with encrypted password 'airflow_celery';
# GRANT all privileges on DATABASE airflow_celery to airflow_celery;
# \c airflow_celery;
# grant all privileges on all tables in schema public to airflow_celery;
```


### pgsql 백업

```
# sudo -u postgres pg_dump -U postgres -Ft -d airflow -v > airflow.dump
# sudo -u postgres pg_dump -U postgres -Ft -d airflow_celery -v > airflow_celery.dump
```

### pgsql 복구

```
# sudo -u postgres pg_restore -U postgres -d "airflow" -v < airflow.dump
# sudo -u postgres pg_restore -U postgres -d "airflow_celery" -v < airflow_celery.dump
```
 

### Migrate mysql airflow db to postgresql airflow db
pgloader mysql://airflow:airflow@localhost:3306/airflow postgresql://airflow:airflow@localhost:5432/airflow

https://info-lab.tistory.com/182


### PSQL DATA DIRECTORY 변경
https://owin2828.github.io/devlog/2020/10/19/etc-8.html


postgres

2021년 10월 1일 금요일

오후 2:48

postgresql 가이드
postgres

2021년 10월 1일 금요일

오후 2:48

postgresql 가이드
http://www.gurubee.net/postgresql/basic

pgbouncer와 pgpool-II 비교 
https://bylee5.tistory.com/46

postgresql 이중화
PostgreSQL pgpool을 활용한 auto-failover 구성 (kimdubi.github.io)
https://kimdubi.github.io/postgresql/pg_pgpool_recovery/
https://kimdubi.github.io/postgresql/postgresql_pgpool/

postgreSQL DB 이중화 구성하기 (master-slave streaming replication & failover) (tistory.com)
https://it-sunny-333.tistory.com/122





기존 데이터 디렉토리 복제 후 사용하지 않을텐데
지우고 심링크 거는게 좋을거같은데....

6. 여기서 data dir 세팅함

7. 설정
   - listen_addresses, max_connection, log_filename 변경
   - 외부 접속 설정
   - 마스터 실행 커맨드???


# pgsql 데이터 디렉토리가 비워져 있어야 백업된다.
pg_basebackup -h icbigloc-01-01 -D /data1/pgsql/13/data -U replication -v -P -X stream

# 이슈 대응
pg_basebackup: error: FATAL:  no pg_hba.conf entry for replication connection from host "172.19.0.2", user "replication", SSL of
f
* Solve: master - pg_hba.conf에 replication이 들어올 수 있도록
host replication replication 172.19.0.2/24 md5



standby_mode='on'

# master 노드의 정보를 적는다.

primary_conninfo='host=icbigloc-01-01 port=5432 user=replication password=replica'

# slave노드에 trigger file이 있으면, slave가 master로 전환된다.

trigger_file='/data1/pgsql/13/data/failover_trigger'



!!! recover.conf가 12버전 이후로 사라졌다
https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=hanccii&logNo=221763572954


replication first
pgpool after


# 2021-10-31 복기
   - 결국엔 replication과 pgpool을 분할해서 생각해야 함
   - 여러 글을 참고하고 try했는데 글 별로 replication 방식이나 버전이 달라 시행착오를 많이 겪음
   - pgpool 공식 문서가 pgsql 13버전과 pgpool2(4.2.5)를 지원해서
   - 이걸로 해봅시다

# 공식문서 진행.....
https://www.pgpool.net/docs/42/en/html/example-cluster.html