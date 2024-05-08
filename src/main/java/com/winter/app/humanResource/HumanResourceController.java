package com.winter.app.humanResource;

import com.winter.app.employee.*;
import com.winter.app.util.commons.CommonsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/hr")
@Slf4j
public class HumanResourceController {

    @Autowired
    private HumanResourceService humanResourceService;

    @Autowired
    private CommonsService commonsService;

    @GetMapping("temp/list")
    public String tempList() throws Exception {
        return "HR/MemberAgree";
    }

    @GetMapping("member")
    public String memberList() throws Exception {
        return "HR/MemberList";
    }

    @GetMapping("salary")
    public ModelAndView salaryList(ModelAndView mv) throws Exception {
        mv.addObject("salYear", humanResourceService.getDistinctValues("SALARY"));
        mv.setViewName("HR/MemberSalary");
        return mv;
    }

    @GetMapping("vacation")
    public ModelAndView vacationList(ModelAndView mv) throws Exception {
        mv.addObject("vacYear", humanResourceService.getDistinctValues("VACATION"));
        mv.setViewName("HR/VacationList");
        return mv;
    }

    @GetMapping("attendance")
    public ModelAndView attendanceManage(ModelAndView mv) throws Exception {
        mv.addObject("checkDate", humanResourceService.getDistinctValues("VACATION"));
        mv.setViewName("HR/AttendenceManage");
        return mv;
    }

    @GetMapping("temp/ask")
    @ResponseBody
    public Map<String, Object> getAskList() throws Exception {
        Map<String, Object> responseData = new HashMap<>();

        Map<String, List<Object>> commons = commonsService.getCommonsList();
        List<TempEmployeeVO> tempEmployeeVOS = humanResourceService.getAskList();

        Map<String, List<TempEmployeeVO>> tempMember = new HashMap<>();
        tempMember.put("tempMember", tempEmployeeVOS);

        responseData.put("tempMember", tempMember.get("tempMember"));
        responseData.put("commons", commons);

        return responseData;
    }

    @PostMapping("temp/ask")
    @ResponseBody
    public int setEmployee(EmployeeVO employeeVO, PositionVO positionVO, DepartmentVO departmentVO, RnRVO rnRVO, WorkTypeVO workTypeVO) throws Exception {

        employeeVO.setPositionVO(positionVO);
        employeeVO.setDepartmentVO(departmentVO);
        employeeVO.setRnrVO(rnRVO);
        employeeVO.setWorkTypeVO(workTypeVO);

        return humanResourceService.setEmployee(employeeVO);
    }

    @PostMapping("temp/del")
    @ResponseBody
    public int delTempEmployee(EmployeeVO employeeVO) throws Exception {
        return humanResourceService.delTempEmployee(employeeVO);
    }

    @GetMapping("member/list")
    @ResponseBody
    public List<Map<String, Object>> getMemberList() throws Exception {
        return humanResourceService.getMemberList();
    }

    @GetMapping("member/detail")
    @ResponseBody
    public Map<String, Object> getMemberDetail(EmployeeVO employeeVO) throws Exception{
        Map<String, Object> response = new HashMap<>();
        response.put("data",humanResourceService.getMemberDetail(employeeVO));
        response.put("commons",commonsService.getCommonsList());

        return response;
    }

    @PostMapping("member/update")
    @ResponseBody
    public void updateMember(@RequestBody Map<String, Object> req) throws Exception{
        int check = humanResourceService.updateMember(req);
    }

    @PostMapping("member/fired")
    @ResponseBody
    public void updateFired(@RequestBody Map<String, Object> req) throws Exception{
        int check = humanResourceService.updateFired(req);
    }

    @GetMapping("resignation/list")
    @ResponseBody
    public Map<String, List<Map<String, Object>>> getResignationList() throws Exception {
        return humanResourceService.getResignationList();
    }

    @PostMapping("resignation/update")
    @ResponseBody
    public int updateResignationList(EmployeeVO employeeVO) throws Exception{
        return humanResourceService.updateResignationList(employeeVO);
    }

    @GetMapping("vacation/list")
    @ResponseBody
    public List<Map<String, Object>> getVacationList(Integer year) throws Exception {
        return humanResourceService.getVacationList(year);
    }

    @GetMapping("salary/list")
    @ResponseBody
    public List<Map<String, Object>> getSalaryList(Integer year) throws Exception {
        return humanResourceService.getSalaryList(year);
    }

    @PostMapping("salary/update")
    @ResponseBody
    public int updateSalary(SalaryVO salaryVO) throws Exception{
        int check = humanResourceService.updateSalary(salaryVO);
        if(check == 1){
            check =  salaryVO.getSalary_year().intValue();
        }
        return check;
    }

    @PostMapping("/attendance/list")
    @ResponseBody
    public Map<String, Object> getAttendanceList(@RequestParam Map<String, Object> req) throws Exception {

        return humanResourceService.getAttendanceList(req);
    }

}
