package com.neo.mybatis.generator.plugin;

import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.PluginAdapter;
import org.mybatis.generator.api.dom.java.*;
import org.mybatis.generator.api.dom.xml.Element;
import org.mybatis.generator.api.dom.xml.TextElement;
import org.mybatis.generator.api.dom.xml.XmlElement;
import org.mybatis.generator.config.Context;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/**
 * Created by wenpeng on 2017/2/7.
 */
public class PaginationPlugin extends PluginAdapter {
    private static SimpleDateFormat df = new SimpleDateFormat("EEE MMM ww HH:mm:ss z yyyy", Locale.US);
    private final static FullyQualifiedJavaType INTEGER_TYPE = new FullyQualifiedJavaType("java.lang.Integer");
    private static final String OFFSET = "offset";
    private static final String LIMIT = "limit";
    private static final String template =
            "<if test=\"offset != null and limit != null\">\n" +
                    "      limit ${offset}, ${limit}\n" +
                    "    </if>";

    @Override
    public boolean validate(List<String> warnings) {
        return true;
    }

    @Override
    public boolean modelExampleClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        String tableName = introspectedTable.getFullyQualifiedTableNameAtRuntime();
        addProperty(OFFSET, INTEGER_TYPE, topLevelClass, this.getContext(), tableName);
        addProperty(LIMIT, INTEGER_TYPE, topLevelClass, this.getContext(), tableName);

        Method method = new Method();
        method.setName("page");
        method.setVisibility(JavaVisibility.PUBLIC);
        method.setReturnType(topLevelClass.getType());
        method.addBodyLine("this.offset = offset;");
        method.addBodyLine("this.limit = limit;");
        method.addBodyLine("return this;");
        method.addParameter(new Parameter(FullyQualifiedJavaType.getIntInstance(), "offset"));
        method.addParameter(new Parameter(FullyQualifiedJavaType.getIntInstance(), "limit"));
        addDoc(this.getContext(), method, tableName);
        topLevelClass.getMethods().add(method);

        System.out.println("-----------------" + topLevelClass.getType().getShortName() + " add method=page for pagination.");
        return true;
    }

    @Override
    public boolean sqlMapSelectByExampleWithBLOBsElementGenerated(XmlElement element, IntrospectedTable introspectedTable) {
        List<Element> els = element.getElements();
        els.add(new TextElement(template));
        return true;
    }

    @Override
    public boolean sqlMapSelectByExampleWithoutBLOBsElementGenerated(XmlElement element, IntrospectedTable introspectedTable) {
        List<Element> els = element.getElements();
        els.add(new TextElement(template));
        return true;
    }

    void addProperty(String field, FullyQualifiedJavaType fieldType, TopLevelClass topLevelClass, Context context, String tableName) {
        for (Method method : topLevelClass.getMethods()) {
            if (method.getName().equals("clear")) {
                method.addBodyLine("this." + field + " = null;");
            }
        }
        topLevelClass.addField(makeStringField(context, field, fieldType, tableName));
        topLevelClass.addMethod(makeGetterStringMethod(context, field, fieldType, tableName));
        topLevelClass.addMethod(makeSetterStringMethod(context, field, fieldType, tableName));
        System.out.println("-----------------" + topLevelClass.getType().getShortName() + " add field " + field + " and getter related.");
    }

    Field makeStringField(Context context, String fieldName, FullyQualifiedJavaType fieldType, String tableName) {
        Field field = new Field();
        field.setName(fieldName);
        field.setVisibility(JavaVisibility.PRIVATE);
        field.setType(fieldType);
        addDoc(context, field, tableName);
        return field;
    }

    Method makeGetterStringMethod(Context context, String fieldName, FullyQualifiedJavaType fieldType, String tableName) {
        String methodName = "get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1, fieldName.length());
        Method method = new Method();
        method.setName(methodName);
        method.setVisibility(JavaVisibility.PUBLIC);
        method.setReturnType(fieldType);
        method.addBodyLine("return this." + fieldName + ";");
        addDoc(context, method, tableName);
        return method;
    }

    Method makeSetterStringMethod(Context context, String fieldName, FullyQualifiedJavaType fieldType, String tableName) {
        String methodName = "set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1, fieldName.length());
        Method method = new Method();
        method.setName(methodName);
        method.setVisibility(JavaVisibility.PUBLIC);
        method.addParameter(new Parameter(fieldType, fieldName));
        method.addBodyLine("this." + fieldName + " = " + fieldName + ";");
        addDoc(context, method, tableName);
        return method;
    }

    void addDoc(Context context, JavaElement element, String tableName) {
        String suppressAllComments = context.getCommentGeneratorConfiguration().getProperty("suppressAllComments");
        if (!"true".equals(suppressAllComments)) {
            String type = element.getClass() == Field.class ? "field" : "method";
            element.addJavaDocLine("/**");
            element.addJavaDocLine("* This " + type + " was generated by MyBatis Generator.");
            element.addJavaDocLine("* This " + type + " corresponds to the database table " + tableName);
            element.addJavaDocLine("*");
            element.addJavaDocLine("* @mbggenerated " + df.format(new Date()));
            element.addJavaDocLine("*/");
        }
    }
}
