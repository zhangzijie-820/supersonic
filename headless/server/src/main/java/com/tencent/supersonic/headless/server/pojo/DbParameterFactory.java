package com.tencent.supersonic.headless.server.pojo;

import com.tencent.supersonic.common.pojo.enums.EngineType;

import java.util.LinkedHashMap;
import java.util.Map;

public class DbParameterFactory {

    private static Map<String, DbParametersBuilder> parametersBuilder;

    static {
        parametersBuilder = new LinkedHashMap<>();
        parametersBuilder.put(EngineType.H2.getName(), new H2ParametersBuilder());
        parametersBuilder.put(EngineType.CLICKHOUSE.getName(), new ClickHouseParametersBuilder());
        parametersBuilder.put(EngineType.MYSQL.getName(), new MysqlParametersBuilder());
        parametersBuilder.put(EngineType.POSTGRESQL.getName(), new PostgresqlParametersBuilder());
        parametersBuilder.put(EngineType.HIVE2.getName(), new Hive2ParameterBuilder());
        parametersBuilder.put(EngineType.OTHER.getName(), new OtherParametersBuilder());
    }

    public static DbParametersBuilder get(String engineType) {
        return parametersBuilder.get(engineType);
    }

    public static Map<String, DbParametersBuilder> getMap() {
        return parametersBuilder;
    }
}
