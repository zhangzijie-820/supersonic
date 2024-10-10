package com.tencent.supersonic.common.pojo.enums;

public enum EngineType {
    TDW(0, "tdw"),
    MYSQL(1, "mysql"),
    DORIS(2, "doris"),
    CLICKHOUSE(3, "clickhouse"),
    KAFKA(4, "kafka"),
    H2(5, "h2"),
    POSTGRESQL(6, "postgresql"),
    HIVE2(7, "hive2"),
    OTHER(8, "other");

    private Integer code;

    private String name;

    EngineType(Integer code, String name) {
        this.code = code;
        this.name = name;
    }

    public Integer getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public static EngineType fromString(String value) {
        for (EngineType engineType : EngineType.values()) {
            if (engineType.name().equalsIgnoreCase(value)) {
                return engineType;
            }
        }
        throw new IllegalArgumentException("Invalid value: " + value);
    }
}
