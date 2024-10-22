package com.tencent.supersonic.headless.core.adaptor.db;

import com.tencent.supersonic.common.pojo.enums.EngineType;

import java.util.HashMap;
import java.util.Map;

public class DbAdaptorFactory {

    private static Map<String, DbAdaptor> dbAdaptorMap;

    static {
        dbAdaptorMap = new HashMap<>();
        dbAdaptorMap.put(EngineType.CLICKHOUSE.getName(), new ClickHouseAdaptor());
        dbAdaptorMap.put(EngineType.MYSQL.getName(), new MysqlAdaptor());
        dbAdaptorMap.put(EngineType.H2.getName(), new H2Adaptor());
        dbAdaptorMap.put(EngineType.POSTGRESQL.getName(), new PostgresqlAdaptor());
        dbAdaptorMap.put(EngineType.HIVE2.getName(), new Hive2Adaptor());
        dbAdaptorMap.put(EngineType.OTHER.getName(), new DefaultDbAdaptor());
    }

    public static DbAdaptor getEngineAdaptor(String engineType) {
        return dbAdaptorMap.get(engineType);
    }
}
