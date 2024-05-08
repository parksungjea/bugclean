package com.winter.app.humanResource;

import com.winter.app.employee.EmployeeVO;
import com.winter.app.employee.RnRVO;
import com.winter.app.util.pagination.Pagination;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class HumanResourceService {

    @Autowired
    private HumanResourceDAO humanResourceDAO;

    @Autowired
    private Pagination pagination;

    private String MatchColums(String column) {
        if (column.equals("1")) {
            return "NAME";
        }
        if (column.equals("2")) {
            return "ATTEND_DATE";
        }
        if (column.equals("3")) {
            return "LATE";
        }
        if (column.equals("4")) {
            return "START_TIME";
        }
        if (column.equals("5")) {
            return "DONE_TIME";
        }
        return "EMPLOYEE_NUM";
    }

    public List<TempEmployeeVO> getAskList() throws Exception {
        return humanResourceDAO.getAskList();
    }

    public List<Map<String, Object>> getMemberList() throws Exception {
        List<Map<String, Object>> memberList = humanResourceDAO.getMemberList();
        for(Map<String, Object> member : memberList){
            String add = (String)member.get("ADDRESS");
            if(add != null){
                Pattern pattern = Pattern.compile("(.*?)\\s(.*?)(시|군|구|$)");
                Matcher matcher = pattern.matcher(add);
                if (matcher.find()) {
                    String parsedAddress = matcher.group(1) + " " + matcher.group(2) + matcher.group(3);
                    member.put("ADDRESS", parsedAddress);
                }
            }
        }
        return setDate(memberList, "JOIN_DATE");
    }

    public Map<String, Object> getMemberDetail(EmployeeVO employeeVO) throws  Exception{
        return humanResourceDAO.getMemberDetail(employeeVO);
    }

    public int updateMember(Map<String, Object> map) throws Exception{
        Long depCode = (map.get("DEP_CODE") instanceof Long) ? (Long) map.get("DEP_CODE") : Long.parseLong((String) map.get("DEP_CODE"));
        Long rnrCode = (map.get("RNR_CODE") instanceof Long) ? (Long) map.get("RNR_CODE") : Long.parseLong((String) map.get("RNR_CODE"));
        Long posCode = (map.get("POS_CODE") instanceof Long) ? (Long) map.get("POS_CODE") : Long.parseLong((String) map.get("POS_CODE"));

        map.put("DEP_CODE", depCode);
        map.put("RNR_CODE", rnrCode);
        map.put("POS_CODE", posCode);

        if (rnrCode == 2L || rnrCode == 1L){
            humanResourceDAO.updateManagerDEP(map);
        }

        return humanResourceDAO.updateMember(map);
    }

    public int updateFired(Map<String, Object> map) throws Exception{
        map.put("state", "0");
        return humanResourceDAO.updateFired(map);
    }

    public Map<String, List<Map<String, Object>>> getResignationList() throws Exception {
        Map<String, List<Map<String, Object>>> responseData = new HashMap<>();
        List<Map<String, Object>> resignationList = humanResourceDAO.getResignationList();

        resignationList = setDate(resignationList, "RETIRED_DATE");
        resignationList = setDate(resignationList, "JOIN_DATE");

        LocalDate currentDate = LocalDate.now();

        List<Map<String, Object>> possible = new ArrayList<>();
        List<Map<String, Object>> impossible = new ArrayList<>();

        for (Map<String, Object> stringObjectMap : resignationList) {
            LocalDate resignedDate = LocalDate.parse((String) stringObjectMap.get("RETIRED_DATE"), DateTimeFormatter.ISO_DATE);
            long daysDifference = ChronoUnit.DAYS.between(resignedDate, currentDate);
            if (daysDifference >= 30) {
                impossible.add(stringObjectMap);
            } else {
                possible.add(stringObjectMap);
            }
            String add = (String)stringObjectMap.get("ADDRESS");
            Pattern pattern = Pattern.compile("(.*?)\\s(.*?)(시|군|구|$)");
            Matcher matcher = pattern.matcher(add);
            if (matcher.find()) {
                String parsedAddress = matcher.group(1) + " " + matcher.group(2) + matcher.group(3);
                stringObjectMap.put("ADDRESS", parsedAddress);
            }
        }

        responseData.put("possible", possible);
        responseData.put("impossible", impossible);
        return responseData;
    }

    private List<Map<String, Object>> setDate(List<Map<String, Object>> list, String col) {
        for (Map<String, Object> stringObjectMap : list) {
            String date = stringObjectMap.get(col).toString();
            int index = date.indexOf(" ");
            if (index != -1) {
                date = date.substring(0, index);
            }
            stringObjectMap.put(col, date);
        }
        return list;
    }

    public List<Map<String, Object>> getVacationList(Integer year) throws Exception {
        return humanResourceDAO.getVacationList(year);
    }

    public List<String> getDistinctValues(String tableName) throws Exception {
        return humanResourceDAO.getDistinctValues(tableName);
    }

    public List<Map<String, Object>> getSalaryList(Integer year) throws Exception {
        List<Map<String, Object>> ar = humanResourceDAO.getSalaryList(year);
        return humanResourceDAO.getSalaryList(year);
    }

    public int updateSalary(SalaryVO salaryVO) throws Exception{
        return humanResourceDAO.updateSalary(salaryVO);
    }

    public Map<String, Object> getAttendanceList(Map<String, Object> req) throws Exception {

        String startDate = (String) req.get("startDate");
        String endDate = (String) req.get("endDate");
        String dir = (String) req.get("dir");
        String column = (String) req.get("column");
        Long page = Long.parseLong((String) req.get("page"));
        Long perPage = Long.parseLong((String) req.get("pageSize"));

        Map<String, Object> date = new HashMap<>();
        date.put("startDate", startDate);
        date.put("endDate", endDate);
        date.put("page", page);
        date.put("perPage", perPage);
        date.put("dir", dir);
        date.put("column", MatchColums(column));

        pagination.setSearch((String) req.get("search"));
        date.put("pagination", pagination);

        Long totalCount = humanResourceDAO.getTotalCount(date);
        pagination.setPage(page);
        pagination.setPerPage(perPage);
        pagination.makeNum(totalCount);
        pagination.makeRow();

        List<Map<String, Object>> list = humanResourceDAO.getAttendanceList(date);
        for (Map<String, Object> empAttendance : list) {
            BigDecimal vac = (BigDecimal) empAttendance.get("ATTEND_VAC");
            if (vac.equals(BigDecimal.ZERO)) {
                empAttendance.put("ATTEND_VAC", false);
            } else if (vac.equals(BigDecimal.ONE)) {
                empAttendance.put("ATTEND_VAC", true);
            } else {
                empAttendance.put("ATTEND_VAC", true);
            }

        }

        Map<String, Object> response = new HashMap<>();
        response.put("data", list);
        response.put("recordsFiltered", totalCount);

        return response;
    }

    public int setEmployee(EmployeeVO employeeVO) throws Exception {
        TempEmployeeVO tempEmployeeVO = humanResourceDAO.getTempMember(employeeVO.getUsername());
        employeeVO.setPassword(tempEmployeeVO.getPassword());
        employeeVO.setPhone(tempEmployeeVO.getPhone());
        employeeVO.setAddress(tempEmployeeVO.getAddress());
        employeeVO.setLevel_date(1L);
        employeeVO.setEmployee_num(humanResourceDAO.getNextNum());
        String manager_num = humanResourceDAO.getManagerNum(employeeVO.getDepartmentVO());
        employeeVO.setManager_num(manager_num);
        employeeVO.setState("1");
        RnRVO rnRVO = new RnRVO();
        rnRVO.setRnr_code(4L);
        employeeVO.setRnrVO(rnRVO);

        log.info("{}",employeeVO);

        int result = humanResourceDAO.setEmployee(employeeVO);
        if (result == 1) {
            result = humanResourceDAO.delTempEmployee(employeeVO.getUsername());
        }
        SalaryVO salaryVO = new SalaryVO();
        salaryVO.setEmployee_num(employeeVO.getEmployee_num());
        LocalDate date = LocalDate.now();
        int year = date.getYear();
        salaryVO.setSalary_year((long)year);
        salaryVO.setSalary_pay(0L);
        result = humanResourceDAO.setSalary(salaryVO);
        VacationVO vacationVO = new VacationVO();
        vacationVO.setEmployee_num(employeeVO.getEmployee_num());
        vacationVO.setVac_year(salaryVO.getSalary_year());
        vacationVO.setVac_full(120L);
        vacationVO.setVac_used(0L);
        result = humanResourceDAO.setVac(vacationVO);
        return result;
    }

    public int delTempEmployee(EmployeeVO employeeVO) throws Exception {
        return humanResourceDAO.delTempEmployee(employeeVO.getUsername());
    }

    public int updateResignationList(EmployeeVO employeeVO) throws Exception{
        employeeVO.setState("1");
        employeeVO.setRetired_date(null);
        return humanResourceDAO.updateResignationList(employeeVO);
    }

}
