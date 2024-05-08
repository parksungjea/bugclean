package com.winter.app.employee;

import com.winter.app.HomeDAO;
import com.winter.app.humanResource.AttendanceVO;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class EmployeeTest {

    @Autowired
    private EmployeeDAO employeeDAO;

    @Autowired
    private HomeDAO homeDAO;

//    @Test
    void creat() throws Exception{

        EmployeeVO employeeVO = new EmployeeVO();

        for (int i=0;i<30;i++){
            employeeVO.setUsername("text"+i+"@gmail.com");
            employeeVO.setPassword("qwer1234!");
            employeeVO.setName("테스트"+i);
            employeeVO.setPhone("010-2222-3333");
            employeeVO.setAddress("서울시 서초구 반포동 반포자이아파트 103동 2301호");
            employeeDAO.create(employeeVO);
        }
    }
    @Test
    void attence() throws Exception{
        AttendanceVO attendanceVO = new AttendanceVO();
        homeDAO.setAttendDate();
    }

}
